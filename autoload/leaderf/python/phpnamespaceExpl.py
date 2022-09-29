#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from leaderf.utils import *
from leaderf.explorer import *
from leaderf.manager import *


# *****************************************************
# PHPNamespaceExplorer
# *****************************************************
class PHPNamespaceExplorer(Explorer):
    def __init__(self):
        self._content = []

    def getContent(self, *args, **kwargs):
        arguments_dict = kwargs.get("arguments", {})

        if (
            "--input" in arguments_dict
            and len(arguments_dict["--input"]) > 0
            or not self._content
        ):
            return self.getFreshContent(*args, **kwargs)
        else:
            return self._content

    def getFreshContent(self, *args, **kwargs):
        cword = None
        arguments_dict = kwargs.get("arguments", {})
        if "--input" in arguments_dict:
            cword = arguments_dict["--input"][0]

        pattern = ".*"
        if cword is not None:
            pattern = "^{0}$".format(cword)

        content = []

        for tag in lfEval("taglist('{0}')".format(pattern)):
            if tag["kind"] == "c" and "namespace" in tag:
                fqcn = tag["namespace"].replace("\\\\", "\\") + "\\" + tag["name"]
                if fqcn not in content:
                    content.append(fqcn)

        if cword is None:
            self._content = content

        return content

    def getStlCategory(self):
        return "PHPNamespace"

    def getStlCurDir(self):
        return escQuote(lfEncode(os.getcwd()))

    def supportsNameOnly(self):
        return True


# *****************************************************
# PHPNamespaceExplManager
# *****************************************************
class PHPNamespaceExplManager(Manager):
    def _getExplClass(self):
        return PHPNamespaceExplorer

    def _defineMaps(self):
        lfCmd("call leaderf#PHPNamespace#Maps()")

    def _acceptSelection(self, *args, **kwargs):
        if len(args) == 0:
            return

        if "--expand" in self.getArguments():
            lfCmd("call leaderf#PHPNamespace#ExpandFQCN('{0}')".format(args[0]))
        else:
            lfCmd("call leaderf#PHPNamespace#ImportFQCN('{0}')".format(args[0]))

    def _getDigest(self, line, mode):
        """
        specify what part in the line to be processed and highlighted
        Args:
            mode: 0, return the full path
                  1, return the name only
                  2, return the directory name
        """
        if not line:
            return ""
        if mode == 0:
            return line
        elif mode == 1:
            return line.rstrip("\\").split("\\")[-1]
        else:
            start_pos = line.rstrip("\\").rfind("\\")
            return line[:start_pos]

    def _getDigestStartPos(self, line, mode):
        """
        specify what part in the line to be processed and highlighted
        Args:
            mode: 0, return the full path
                  1, return the name only
                  2, return the directory name
        """
        if not line:
            return 0

        if mode == 1:
            start_pos = line.rstrip("\\").rfind("\\")
            if start_pos < 0:
                start_pos = 0
            return lfBytesLen(line[: start_pos + 1])
        else:
            return 0

    def _createHelp(self):
        help = []
        help.append('" <CR>/<double-click>/o : import the class under cursor')
        # help.append('" t : open the class under cursor in a new tab')
        help.append('" i : switch to the input mode')
        help.append('" q : quit')
        help.append('" <F1> : toggle this help')
        help.append('" <F5> : refresh the cache')
        help.append('" ---------------------------------------------------------')
        return help


# *****************************************************
# phpnamespaceExplManager is a singleton
# *****************************************************
phpnamespaceExplManager = PHPNamespaceExplManager()

__all__ = ["phpnamespaceExplManager"]

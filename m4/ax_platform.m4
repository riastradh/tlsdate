# ===========================================================================
#       http://
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PLATFORM
#
# DESCRIPTION
#
#   Provide target and host defines.
#
# LICENSE
#
#   Copyright (c) 2012 Brian Aker <brian@tangent.org>
#   Copyleft  (ↄ) 2013 Jacob Appelbaum <jacob@appelbaum.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 1
  AC_DEFUN([AX_PLATFORM],
      [AC_REQUIRE([AC_CANONICAL_HOST])
      AC_REQUIRE([AC_CANONICAL_TARGET])

      AC_DEFINE_UNQUOTED([HOST_VENDOR],["$host_vendor"],[Vendor of Build System])
      AC_DEFINE_UNQUOTED([HOST_OS],["$host_os"], [OS of Build System])
      AC_DEFINE_UNQUOTED([HOST_CPU],["$host_cpu"], [CPU of Build System])

      AC_DEFINE_UNQUOTED([TARGET_VENDOR],["$target_vendor"],[Vendor of Target System])
      AC_DEFINE_UNQUOTED([TARGET_OS],["$target_os"], [OS of Target System])
      AC_DEFINE_UNQUOTED([TARGET_CPU],["$target_cpu"], [CPU of Target System])

      AS_CASE([$target_os],
        [*mingw32*],
        [TARGET_WINDOWS="true"
	AC_DEFINE([TARGET_OS_WINDOWS], [1], [Whether we are building for Windows])
        AC_DEFINE([WINVER], [WindowsXP], [Version of Windows])
        AC_DEFINE([_WIN32_WINNT], [0x0501], [Magical number to make things work])
        AC_DEFINE([EAI_SYSTEM], [11], [Another magical number])
        AH_BOTTOM([
#ifndef HAVE_SYS_SOCKET_H
# define SHUT_RD SD_RECEIVE
# define SHUT_WR SD_SEND
# define SHUT_RDWR SD_BOTH
#endif
          ])],
        [*freebsd*],
        [TARGET_OS_FREEBSD="true"
        AC_DEFINE([TARGET_OS_FREEBSD],[1],[Whether we are building for FreeBSD])],
        [*netbsd*],
        [TARGET_OS_NETBSD="true"
        AC_DEFINE([TARGET_OS_NETBSD],[1],[Whether we are building for NetBSD])],
        [*openbsd*],
        [TARGET_OS_OPENBSD="true"
        AC_DEFINE([TARGET_OS_OPENBSD],[1],[Whether we are building for OpenBSD])],
        [*bsd*],
        [TARGET_OS_BSD="true"
        AC_DEFINE([TARGET_OS_BSD],[1],[Whether we are building for some other *BSD])],
        [*solaris*],[AC_DEFINE([TARGET_OS_SOLARIS],[1],[Whether we are building for Solaris])],
        [*darwin*],
	[TARGET_OSX="true"
	AC_DEFINE([TARGET_OS_OSX],[1],[Whether we build for OSX])],
	[*linux*],
	[TARGET_LINUX="true"
	AC_DEFINE([TARGET_OS_LINUX],[1],[Whether we build for Linux])])

  AM_CONDITIONAL([BUILD_WIN32],[test "x${TARGET_WINDOWS}" = "xtrue"])
  AM_CONDITIONAL([TARGET_OSX],[test "x${TARGET_OSX}" = "xtrue"])
  AM_CONDITIONAL([TARGET_LINUX],[test "x${TARGET_LINUX}" = "xtrue"])
  AM_CONDITIONAL([TARGET_FREEBSD],[test "x${TARGET_OS_FREEBSD}" = "xtrue"])
  AM_CONDITIONAL([TARGET_NETBSD],[test "x${TARGET_OS_NETBSD}" = "xtrue"])
  AM_CONDITIONAL([TARGET_OPENBSD],[test "x${TARGET_OS_OPENBSD}" = "xtrue"])
  AM_CONDITIONAL([TARGET_BSD],[test "x${TARGET_OS_BSD}" = "xtrue"])
  ])

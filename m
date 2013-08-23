From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 3/4] gcov: compile specific gcov implementation based
 on gcc version
Date: Fri, 23 Aug 2013 17:21:12 +0200
Message-ID: <52177DE8.6090704@linux.vnet.ibm.com>
References: <1377247176-13537-1-git-send-email-fhrbata@redhat.com> <1377247176-13537-4-git-send-email-fhrbata@redhat.com> <52177C87.4090003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:48772 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab3HWPVP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2013 11:21:15 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <oberpar@linux.vnet.ibm.com>;
	Fri, 23 Aug 2013 16:15:58 +0100
In-Reply-To: <52177C87.4090003@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frantisek Hrbata <fhrbata@redhat.com>
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com

On 23.08.2013 17:15, Peter Oberparleiter wrote:
> On 23.08.2013 10:39, Frantisek Hrbata wrote:
>> Compile the correct gcov implementation file for a specific gcc version. In
>> the future, if another file is added, the conditions will need to be somehow
>> adjusted to if-elif-else case, but at this point the simple cc-ifversion should
>> be enough.

As promised, I'm also adding the patch that makes the format-specific part
of gcov-kernel a loadable kernel module:

---
kernel: gcov: make format-specific code loadable

Turn the format-specific part of gcov-kernel into a loadable kernel
module. This enables the use of gcov-kernel with kernel modules
that were compiled with a version of GCC that produces a different
gcov format when compared to the version of GCC that was used to
compile the kernel.

Signed-off-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
---
 kernel/gcov/Kconfig  |   19 +++++++++++++++++--
 kernel/gcov/Makefile |    7 ++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -29,8 +29,23 @@ config GCOV_KERNEL
 	and:
 	        GCOV_PROFILE := n

-	Note that the debugfs filesystem has to be mounted to access
-	profiling data.
+	Note that GCOV_KERNEL_FS has to specified as well and the debugfs
+	filesystem has to be mounted to access profiling data.
+
+config GCOV_KERNEL_FS
+	tristate "Provide gcov data files in debugfs"
+	depends on GCOV_KERNEL
+	default y
+	---help---
+	Make profiling data available in debugfs at /sys/kernel/debug/gcov.
+
+	Say M if you want to enable collecting coverage data for kernel modules
+	which are compiled using a gcc version different from the one that
+	was used to compile the kernel. In that case, re-compile the gcov
+	kernel module with corresponding format support and load that module
+	instead.
+
+	If unsure, say Y.

 config GCOV_PROFILE_ALL
 	bool "Profile entire Kernel"
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -13,10 +13,11 @@ else
   cc-ver := $(call cc-version)
 endif

-obj-$(CONFIG_GCOV_KERNEL) := base.o fs.o
+obj-$(CONFIG_GCOV_KERNEL) += base.o
+obj-$(CONFIG_GCOV_KERNEL_FS) += gcov.o

 ifeq ($(call if-lt, $(cc-ver), 0407),1)
-  obj-$(CONFIG_GCOV_KERNEL) += gcc_3_4.o
+  gcov-objs += fs.o gcc_3_4.o
 else
-  obj-$(CONFIG_GCOV_KERNEL) += gcc_4_7.o
+  gcov-objs += fs.o gcc_4_7.o
 endif

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany

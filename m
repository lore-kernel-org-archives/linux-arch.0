From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core] locking/refcount: Create unchecked atomic_t
 implementation
Date: Wed, 6 Sep 2017 10:17:50 +0200
Message-ID: <20170906081750.sjtpodtoh56fgr4o@hirez.programming.kicks-ass.net>
References: <20170621200026.GA115679@beast>
 <tip-fd25d19f6b8da315332bb75936605fb45d3ea981@git.kernel.org>
 <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
 <20170904173444.GA7233@avx2>
 <20170904193643.GC17526@worktop.programming.kicks-ass.net>
 <20170905181536.GA7482@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170905181536.GA7482@avx2>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: davem@davemloft.net, arnd@arndb.de, manfred@colorfullife.com, riel@redhat.com, hpa@zytor.com, ebiggers3@gmail.com, elena.reshetova@intel.com, keescook@chromium.org, dwindsor@gmail.com, mingo@kernel.org, jannh@google.com, serge@hallyn.com, gregkh@linuxfoundation.org, ebiederm@xmission.com, ishkamiel@gmail.com, tglx@linutronix.de, hch@infradead.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave@stgolabs.net, linux-arch@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-tip-commits@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 05, 2017 at 09:15:36PM +0300, Alexey Dobriyan wrote:

> It is not a policy, just a "grassroot" movement to give people good
> example and wait until someone is annoyed enough to mass convert
> everything. -)

Well, its a mess and I cleaned up the outliers.

> Worked for fs/proc/Makefile .

No, that file is still a mess; the below is what it would take to clean
up according to your preferred pattern.

So go spend an hour or so and write a script that cleans this all up and
convince Linus to run it. Otherwise I really can't be arsed with this
nonsense.

---
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index 12c6922c913c..8c19ab50eb7f 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -5,29 +5,35 @@
 obj-y   += proc.o
 
 CFLAGS_task_mmu.o	+= $(call cc-option,-Wno-override-init,)
+
 proc-y			:= nommu.o task_nommu.o
 proc-$(CONFIG_MMU)	:= task_mmu.o
 
-proc-y       += inode.o root.o base.o generic.o array.o \
-		fd.o
-proc-$(CONFIG_TTY)      += proc_tty.o
-proc-y	+= cmdline.o
-proc-y	+= consoles.o
-proc-y	+= cpuinfo.o
-proc-y	+= devices.o
-proc-y	+= interrupts.o
-proc-y	+= loadavg.o
-proc-y	+= meminfo.o
-proc-y	+= stat.o
-proc-y	+= uptime.o
-proc-y	+= version.o
-proc-y	+= softirqs.o
-proc-y	+= namespaces.o
-proc-y	+= self.o
-proc-y	+= thread_self.o
-proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
-proc-$(CONFIG_NET)		+= proc_net.o
-proc-$(CONFIG_PROC_KCORE)	+= kcore.o
-proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
-proc-$(CONFIG_PRINTK)	+= kmsg.o
-proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
+proc-y += array.o
+proc-y += base.o
+proc-y += cmdline.o
+proc-y += consoles.o
+proc-y += cpuinfo.o
+proc-y += devices.o
+proc-y += fd.o
+proc-y += generic.o
+proc-y += inode.o
+proc-y += interrupts.o
+proc-y += loadavg.o
+proc-y += meminfo.o
+proc-y += namespaces.o
+proc-y += root.o
+proc-y += self.o
+proc-y += softirqs.o
+proc-y += stat.o
+proc-y += thread_self.o
+proc-y += uptime.o
+proc-y += version.o
+
+PROC-$(config_net)		+= PROC_NET.O
+PROC-$(config_printk)		+= KMSG.O
+PROC-$(config_proc_kcore)	+= KCORE.O
+PROC-$(config_proc_page_monitor)+= PAGE.O
+PROC-$(config_proc_sysctl)	+= PROC_SYSCTL.O
+PROC-$(config_proc_vmcore)	+= VMCORE.O
+PROC-$(config_tty)		+= PROC_TTY.O

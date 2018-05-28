From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 26/27] Documentation: kprobes: Add how to change the execution path
Date: Mon, 28 May 2018 16:12:40 +0900
Message-ID: <152749156011.15132.15417205958490100087.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>, Alexei Starovoitov <ast@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
List-Id: linux-arch.vger.kernel.org

Add a section that explaining how to change the execution
path with kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/kprobes.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 3e9e99ea751b..8a98eed1521b 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
 "post_handler," if any, that is associated with the kprobe.
 Execution then continues with the instruction following the probepoint.
 
+Changing Execution Path
+-----------------------
+
+Since the kprobes can probe into a running kernel code, it can change
+the register set, including instruction pointer. This operation
+requires maximum attention, such as keeping the stack frame, recovering
+execution path etc. Since it is operated on running kernel and need deep
+knowladge of the archtecture and concurrent computing, you can easily
+shot your foot.
+
+If you change the instruction pointer (and set up other related
+registers) in pre_handler, you must return !0 so that the kprobes
+stops single stepping and just returns to given address.
+This also means post_handler should not be called anymore.
+
+Note that this operation may be harder on some architectures which
+use TOC (Table of Contents) for function call, since you have to
+setup new TOC for your function in your module, and recover old
+one after back from it.
+
 Return Probes
 -------------
 

From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 45/45] bpf: whitelist all syscalls for error injection
Date: Thu, 22 Mar 2018 10:00:59 +0100
Message-ID: <20180322090059.19361-46-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Howard McLauchlan <hmclauchlan@fb.com>
List-Id: linux-arch.vger.kernel.org

From: Howard McLauchlan <hmclauchlan@fb.com>

Error injection is a useful mechanism to fail arbitrary kernel
functions. However, it is often hard to guarantee an error propagates
appropriately to user space programs. By injecting into syscalls, we can
return arbitrary values to user space directly; this increases
flexibility and robustness in testing, allowing us to test user space
error paths effectively.

The following script, for example, fails calls to sys_open() from a
given pid:

from bcc import BPF
from sys import argv

pid = argv[1]

prog = r"""

int kprobe__SyS_open(struct pt_regs *ctx, const char *pathname, int flags)
{
    u32 pid = bpf_get_current_pid_tgid();
    if (pid == %s)
        bpf_override_return(ctx, -ENOMEM);
    return 0;
}
""" % pid

b = BPF(text=prog)
while 1:
    b.perf_buffer_poll()

This patch whitelists all syscalls defined with SYSCALL_DEFINE and
COMPAT_SYSCALL_DEFINE for error injection. These changes are not
intended to be considered stable, and would normally be configured off.

Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/compat.h   | 3 +++
 include/linux/syscalls.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f1649a5e6716..57eb263a3bc9 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -33,6 +33,8 @@
 #endif
 
 #define COMPAT_SYSCALL_DEFINE0(name) \
+	asmlinkage long compat_sys_##name(void); \
+	ALLOW_ERROR_INJECTION(compat_sys_##name, ERRNO); \
 	asmlinkage long compat_sys_##name(void)
 
 #define COMPAT_SYSCALL_DEFINE1(name, ...) \
@@ -51,6 +53,7 @@
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
 		__attribute__((alias(__stringify(compat_SyS##name))));  \
+	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);	\
 	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));\
 	asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3591c4af33d8..cc6fcd7d5b3c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
+	asmlinkage long sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
 
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
@@ -210,6 +212,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(SyS##name))));		\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-- 
2.16.2

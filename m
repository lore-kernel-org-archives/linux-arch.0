From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 105/109] syscalls: sort syscall prototypes in include/linux/compat.h
Date: Thu, 29 Mar 2018 13:24:22 +0200
Message-ID: <20180329112426.23043-106-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Shuffle the syscall prototypes in include/linux/compat.h around so
that they are kept in the same order as in
include/uapi/asm-generic/unistd.h. The individual entries are kept
the same, and neither modified to bring them in line with kernel coding
style nor wrapped in proper ifdefs -- as an exception to this, add the
prefix "asmlinkage" where it was missing.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/compat.h | 655 ++++++++++++++++++++++++++++---------------------
 1 file changed, 378 insertions(+), 277 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f1649a5e6716..f881cce627f6 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -305,10 +305,6 @@ extern int put_compat_rusage(const struct rusage *,
 
 struct compat_siginfo;
 
-extern asmlinkage long compat_sys_waitid(int, compat_pid_t,
-		struct compat_siginfo __user *, int,
-		struct compat_rusage __user *);
-
 struct compat_dirent {
 	u32		d_ino;
 	compat_off_t	d_off;
@@ -422,90 +418,6 @@ struct compat_msgbuf;
 
 extern void compat_exit_robust_list(struct task_struct *curr);
 
-asmlinkage long
-compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
-			   compat_size_t len);
-asmlinkage long
-compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
-			   compat_size_t __user *len_ptr);
-
-asmlinkage long compat_sys_ipc(u32, int, int, u32, compat_uptr_t, u32);
-asmlinkage long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg);
-asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
-asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
-		compat_ssize_t msgsz, int msgflg);
-asmlinkage long compat_sys_msgrcv(int msqid, compat_uptr_t msgp,
-		compat_ssize_t msgsz, compat_long_t msgtyp, int msgflg);
-long compat_sys_msgctl(int first, int second, void __user *uptr);
-long compat_sys_shmctl(int first, int second, void __user *uptr);
-long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
-		unsigned nsems, const struct compat_timespec __user *timeout);
-asmlinkage long compat_sys_keyctl(u32 option,
-			      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
-asmlinkage long compat_sys_ustat(unsigned dev, struct compat_ustat __user *u32);
-
-asmlinkage ssize_t compat_sys_readv(compat_ulong_t fd,
-		const struct compat_iovec __user *vec, compat_ulong_t vlen);
-asmlinkage ssize_t compat_sys_writev(compat_ulong_t fd,
-		const struct compat_iovec __user *vec, compat_ulong_t vlen);
-asmlinkage ssize_t compat_sys_preadv(compat_ulong_t fd,
-		const struct compat_iovec __user *vec,
-		compat_ulong_t vlen, u32 pos_low, u32 pos_high);
-asmlinkage ssize_t compat_sys_pwritev(compat_ulong_t fd,
-		const struct compat_iovec __user *vec,
-		compat_ulong_t vlen, u32 pos_low, u32 pos_high);
-asmlinkage ssize_t compat_sys_preadv2(compat_ulong_t fd,
-		const struct compat_iovec __user *vec,
-		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
-asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
-		const struct compat_iovec __user *vec,
-		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
-
-asmlinkage long compat_sys_quotactl32(unsigned int cmd,
-		const char __user *special, qid_t id, void __user *addr);
-
-#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
-asmlinkage long compat_sys_preadv64(unsigned long fd,
-		const struct compat_iovec __user *vec,
-		unsigned long vlen, loff_t pos);
-#endif
-
-#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
-asmlinkage long compat_sys_pwritev64(unsigned long fd,
-		const struct compat_iovec __user *vec,
-		unsigned long vlen, loff_t pos);
-#endif
-
-#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
-asmlinkage long  compat_sys_readv64v2(unsigned long fd,
-		const struct compat_iovec __user *vec,
-		unsigned long vlen, loff_t pos, rwf_t flags);
-#endif
-
-#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
-asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
-		const struct compat_iovec __user *vec,
-		unsigned long vlen, loff_t pos, rwf_t flags);
-#endif
-
-asmlinkage long compat_sys_lseek(unsigned int, compat_off_t, unsigned int);
-
-asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
-		     const compat_uptr_t __user *envp);
-asmlinkage long compat_sys_execveat(int dfd, const char __user *filename,
-		     const compat_uptr_t __user *argv,
-		     const compat_uptr_t __user *envp, int flags);
-
-asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
-		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-		struct compat_timeval __user *tvp);
-
-asmlinkage long compat_sys_old_select(struct compat_sel_arg_struct __user *arg);
-
-asmlinkage long compat_sys_wait4(compat_pid_t pid,
-				 compat_uint_t __user *stat_addr, int options,
-				 struct compat_rusage __user *ru);
-
 #define BITS_PER_COMPAT_LONG    (8*sizeof(compat_long_t))
 
 #define BITS_TO_COMPAT_LONGS(bits) DIV_ROUND_UP(bits, BITS_PER_COMPAT_LONG)
@@ -518,13 +430,6 @@ int copy_siginfo_from_user32(siginfo_t *to, const struct compat_siginfo __user *
 int copy_siginfo_to_user32(struct compat_siginfo __user *to, const siginfo_t *from);
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
-long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid, compat_pid_t pid, int sig,
-				  struct compat_siginfo __user *uinfo);
-#ifdef CONFIG_COMPAT_OLD_SIGACTION
-asmlinkage long compat_sys_sigaction(int sig,
-                                   const struct compat_old_sigaction __user *act,
-                                   struct compat_old_sigaction __user *oact);
-#endif
 
 static inline int compat_timeval_compare(struct compat_timeval *lhs,
 					struct compat_timeval *rhs)
@@ -546,13 +451,6 @@ static inline int compat_timespec_compare(struct compat_timespec *lhs,
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
-asmlinkage long compat_sys_gettimeofday(struct compat_timeval __user *tv,
-		struct timezone __user *tz);
-asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv,
-		struct timezone __user *tz);
-
-asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
-
 extern int get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat);
 
 /*
@@ -578,110 +476,132 @@ put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
 #endif
 }
 
-asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
-		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
-		const compat_ulong_t __user *new_nodes);
-
 extern int compat_ptrace_request(struct task_struct *child,
 				 compat_long_t request,
 				 compat_ulong_t addr, compat_ulong_t data);
 
 extern long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			       compat_ulong_t addr, compat_ulong_t data);
-asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
-				  compat_long_t addr, compat_long_t data);
 
-asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
+struct epoll_event;	/* fortunately, this one is fixed-layout */
+
+extern ssize_t compat_rw_copy_check_uvector(int type,
+		const struct compat_iovec __user *uvector,
+		unsigned long nr_segs,
+		unsigned long fast_segs, struct iovec *fast_pointer,
+		struct iovec **ret_pointer);
+
+extern void __user *compat_alloc_user_space(unsigned long len);
+
+int compat_restore_altstack(const compat_stack_t __user *uss);
+int __compat_save_altstack(compat_stack_t __user *, unsigned long);
+#define compat_save_altstack_ex(uss, sp) do { \
+	compat_stack_t __user *__uss = uss; \
+	struct task_struct *t = current; \
+	put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp), &__uss->ss_sp); \
+	put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
+	put_user_ex(t->sas_ss_size, &__uss->ss_size); \
+	if (t->sas_ss_flags & SS_AUTODISARM) \
+		sas_ss_reset(t); \
+} while (0);
+
 /*
- * epoll (fs/eventpoll.c) compat bits follow ...
+ * These syscall function prototypes are kept in the same order as
+ * include/uapi/asm-generic/unistd.h. Architecture specific entries go below,
+ * followed by deprecated or obsolete system calls.
+ *
+ * Please note that these prototypes here are only provided for information
+ * purposes, for static analysis, and for linking from the syscall table.
+ * These functions should not be called elsewhere from kernel code.
  */
-struct epoll_event;	/* fortunately, this one is fixed-layout */
+asmlinkage long compat_sys_io_setup(unsigned nr_reqs, u32 __user *ctx32p);
+asmlinkage long compat_sys_io_submit(compat_aio_context_t ctx_id, int nr,
+				     u32 __user *iocb);
+asmlinkage long compat_sys_io_getevents(compat_aio_context_t ctx_id,
+					compat_long_t min_nr,
+					compat_long_t nr,
+					struct io_event __user *events,
+					struct compat_timespec __user *timeout);
+
+/* fs/cookies.c */
+asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
+
+/* fs/eventpoll.c */
 asmlinkage long compat_sys_epoll_pwait(int epfd,
 			struct epoll_event __user *events,
 			int maxevents, int timeout,
 			const compat_sigset_t __user *sigmask,
 			compat_size_t sigsetsize);
 
-asmlinkage long compat_sys_utime(const char __user *filename,
-				 struct compat_utimbuf __user *t);
-asmlinkage long compat_sys_utimensat(unsigned int dfd,
-				     const char __user *filename,
-				     struct compat_timespec __user *t,
-				     int flags);
+/* fs/fcntl.c */
+asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
+				 compat_ulong_t arg);
+asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
+				   compat_ulong_t arg);
 
-asmlinkage long compat_sys_time(compat_time_t __user *tloc);
-asmlinkage long compat_sys_stime(compat_time_t __user *tptr);
-asmlinkage long compat_sys_signalfd(int ufd,
-				    const compat_sigset_t __user *sigmask,
-				    compat_size_t sigsetsize);
-asmlinkage long compat_sys_timerfd_settime(int ufd, int flags,
-				   const struct compat_itimerspec __user *utmr,
-				   struct compat_itimerspec __user *otmr);
-asmlinkage long compat_sys_timerfd_gettime(int ufd,
-				   struct compat_itimerspec __user *otmr);
+/* fs/ioctl.c */
+asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
+				 compat_ulong_t arg);
 
-asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
-				      __u32 __user *pages,
-				      const int __user *nodes,
-				      int __user *status,
-				      int flags);
-asmlinkage long compat_sys_futimesat(unsigned int dfd,
-				     const char __user *filename,
-				     struct compat_timeval __user *t);
-asmlinkage long compat_sys_utimes(const char __user *filename,
-				  struct compat_timeval __user *t);
-asmlinkage long compat_sys_newstat(const char __user *filename,
-				   struct compat_stat __user *statbuf);
-asmlinkage long compat_sys_newlstat(const char __user *filename,
-				    struct compat_stat __user *statbuf);
-asmlinkage long compat_sys_newfstatat(unsigned int dfd,
-				      const char __user *filename,
-				      struct compat_stat __user *statbuf,
-				      int flag);
-asmlinkage long compat_sys_newfstat(unsigned int fd,
-				    struct compat_stat __user *statbuf);
+/* fs/namespace.c */
+asmlinkage long compat_sys_mount(const char __user *dev_name,
+				 const char __user *dir_name,
+				 const char __user *type, compat_ulong_t flags,
+				 const void __user *data);
+
+/* fs/open.c */
 asmlinkage long compat_sys_statfs(const char __user *pathname,
 				  struct compat_statfs __user *buf);
-asmlinkage long compat_sys_fstatfs(unsigned int fd,
-				   struct compat_statfs __user *buf);
 asmlinkage long compat_sys_statfs64(const char __user *pathname,
 				    compat_size_t sz,
 				    struct compat_statfs64 __user *buf);
+asmlinkage long compat_sys_fstatfs(unsigned int fd,
+				   struct compat_statfs __user *buf);
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
-asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
-				   compat_ulong_t arg);
-asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
-				 compat_ulong_t arg);
-asmlinkage long compat_sys_io_setup(unsigned nr_reqs, u32 __user *ctx32p);
-asmlinkage long compat_sys_io_getevents(compat_aio_context_t ctx_id,
-					compat_long_t min_nr,
-					compat_long_t nr,
-					struct io_event __user *events,
-					struct compat_timespec __user *timeout);
-asmlinkage long compat_sys_io_submit(compat_aio_context_t ctx_id, int nr,
-				     u32 __user *iocb);
-asmlinkage long compat_sys_mount(const char __user *dev_name,
-				 const char __user *dir_name,
-				 const char __user *type, compat_ulong_t flags,
-				 const void __user *data);
-asmlinkage long compat_sys_old_readdir(unsigned int fd,
-				       struct compat_old_linux_dirent __user *,
-				       unsigned int count);
+asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
+asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
+/* No generic prototype for truncate64, ftruncate64, fallocate */
+asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
+				  int flags, umode_t mode);
+
+/* fs/readdir.c */
 asmlinkage long compat_sys_getdents(unsigned int fd,
 				    struct compat_linux_dirent __user *dirent,
 				    unsigned int count);
-asmlinkage long compat_sys_vmsplice(int fd, const struct compat_iovec __user *,
-				    unsigned int nr_segs, unsigned int flags);
-asmlinkage long compat_sys_open(const char __user *filename, int flags,
-				umode_t mode);
-asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
-				  int flags, umode_t mode);
-asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
-					     struct file_handle __user *handle,
-					     int flags);
-asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
-asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
+
+/* fs/read_write.c */
+asmlinkage long compat_sys_lseek(unsigned int, compat_off_t, unsigned int);
+asmlinkage ssize_t compat_sys_readv(compat_ulong_t fd,
+		const struct compat_iovec __user *vec, compat_ulong_t vlen);
+asmlinkage ssize_t compat_sys_writev(compat_ulong_t fd,
+		const struct compat_iovec __user *vec, compat_ulong_t vlen);
+/* No generic prototype for pread64 and pwrite64 */
+asmlinkage ssize_t compat_sys_preadv(compat_ulong_t fd,
+		const struct compat_iovec __user *vec,
+		compat_ulong_t vlen, u32 pos_low, u32 pos_high);
+asmlinkage ssize_t compat_sys_pwritev(compat_ulong_t fd,
+		const struct compat_iovec __user *vec,
+		compat_ulong_t vlen, u32 pos_low, u32 pos_high);
+#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
+asmlinkage long compat_sys_preadv64(unsigned long fd,
+		const struct compat_iovec __user *vec,
+		unsigned long vlen, loff_t pos);
+#endif
+
+#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
+asmlinkage long compat_sys_pwritev64(unsigned long fd,
+		const struct compat_iovec __user *vec,
+		unsigned long vlen, loff_t pos);
+#endif
+
+/* fs/sendfile.c */
+asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
+				    compat_off_t __user *offset, compat_size_t count);
+asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
+				    compat_loff_t __user *offset, compat_size_t count);
+
+/* fs/select.c */
 asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
 				    compat_ulong_t __user *outp,
 				    compat_ulong_t __user *exp,
@@ -692,110 +612,149 @@ asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
 				 struct compat_timespec __user *tsp,
 				 const compat_sigset_t __user *sigmask,
 				 compat_size_t sigsetsize);
+
+/* fs/signalfd.c */
 asmlinkage long compat_sys_signalfd4(int ufd,
 				     const compat_sigset_t __user *sigmask,
 				     compat_size_t sigsetsize, int flags);
-asmlinkage long compat_sys_get_mempolicy(int __user *policy,
-					 compat_ulong_t __user *nmask,
-					 compat_ulong_t maxnode,
-					 compat_ulong_t addr,
-					 compat_ulong_t flags);
-asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
-					 compat_ulong_t maxnode);
-asmlinkage long compat_sys_mbind(compat_ulong_t start, compat_ulong_t len,
-				 compat_ulong_t mode,
-				 compat_ulong_t __user *nmask,
-				 compat_ulong_t maxnode, compat_ulong_t flags);
 
-asmlinkage long compat_sys_setsockopt(int fd, int level, int optname,
-				      char __user *optval, unsigned int optlen);
-asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
-				   unsigned flags);
-asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
-				    unsigned vlen, unsigned int flags);
-asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
-				   unsigned int flags);
-asmlinkage long compat_sys_recv(int fd, void __user *buf, compat_size_t len,
-				unsigned flags);
-asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
-			    unsigned flags, struct sockaddr __user *addr,
-			    int __user *addrlen);
-asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
-				    unsigned vlen, unsigned int flags,
-				    struct compat_timespec __user *timeout);
+/* fs/splice.c */
+asmlinkage long compat_sys_vmsplice(int fd, const struct compat_iovec __user *,
+				    unsigned int nr_segs, unsigned int flags);
+
+/* fs/stat.c */
+asmlinkage long compat_sys_newfstatat(unsigned int dfd,
+				      const char __user *filename,
+				      struct compat_stat __user *statbuf,
+				      int flag);
+asmlinkage long compat_sys_newfstat(unsigned int fd,
+				    struct compat_stat __user *statbuf);
+
+/* fs/sync.c: No generic prototype for sync_file_range and sync_file_range2 */
+
+/* fs/timerfd.c */
+asmlinkage long compat_sys_timerfd_gettime(int ufd,
+				   struct compat_itimerspec __user *otmr);
+asmlinkage long compat_sys_timerfd_settime(int ufd, int flags,
+				   const struct compat_itimerspec __user *utmr,
+				   struct compat_itimerspec __user *otmr);
+
+/* fs/utimes.c */
+asmlinkage long compat_sys_utimensat(unsigned int dfd,
+				     const char __user *filename,
+				     struct compat_timespec __user *t,
+				     int flags);
+
+/* kernel/exit.c */
+asmlinkage long compat_sys_waitid(int, compat_pid_t,
+		struct compat_siginfo __user *, int,
+		struct compat_rusage __user *);
+
+
+
+/* kernel/futex.c */
+asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
+		struct compat_timespec __user *utime, u32 __user *uaddr2,
+		u32 val3);
+asmlinkage long
+compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
+			   compat_size_t len);
+asmlinkage long
+compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
+			   compat_size_t __user *len_ptr);
+
+/* kernel/hrtimer.c */
 asmlinkage long compat_sys_nanosleep(struct compat_timespec __user *rqtp,
 				     struct compat_timespec __user *rmtp);
+
+/* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct compat_itimerval __user *it);
 asmlinkage long compat_sys_setitimer(int which,
 				     struct compat_itimerval __user *in,
 				     struct compat_itimerval __user *out);
-asmlinkage long compat_sys_times(struct compat_tms __user *tbuf);
-asmlinkage long compat_sys_setrlimit(unsigned int resource,
-				     struct compat_rlimit __user *rlim);
-asmlinkage long compat_sys_getrlimit(unsigned int resource,
-				     struct compat_rlimit __user *rlim);
-asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
-asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
-				     unsigned int len,
-				     compat_ulong_t __user *user_mask_ptr);
-asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
-				     unsigned int len,
-				     compat_ulong_t __user *user_mask_ptr);
+
+/* kernel/kexec.c */
+asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
+				      compat_ulong_t nr_segments,
+				      struct compat_kexec_segment __user *,
+				      compat_ulong_t flags);
+
+/* kernel/posix-timers.c */
 asmlinkage long compat_sys_timer_create(clockid_t which_clock,
 			struct compat_sigevent __user *timer_event_spec,
 			timer_t __user *created_timer_id);
+asmlinkage long compat_sys_timer_gettime(timer_t timer_id,
+				 struct compat_itimerspec __user *setting);
 asmlinkage long compat_sys_timer_settime(timer_t timer_id, int flags,
 					 struct compat_itimerspec __user *new,
 					 struct compat_itimerspec __user *old);
-asmlinkage long compat_sys_timer_gettime(timer_t timer_id,
-				 struct compat_itimerspec __user *setting);
 asmlinkage long compat_sys_clock_settime(clockid_t which_clock,
 					 struct compat_timespec __user *tp);
 asmlinkage long compat_sys_clock_gettime(clockid_t which_clock,
 					 struct compat_timespec __user *tp);
-asmlinkage long compat_sys_clock_adjtime(clockid_t which_clock,
-					 struct compat_timex __user *tp);
 asmlinkage long compat_sys_clock_getres(clockid_t which_clock,
 					struct compat_timespec __user *tp);
 asmlinkage long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
 					   struct compat_timespec __user *rqtp,
 					   struct compat_timespec __user *rmtp);
-asmlinkage long compat_sys_rt_sigtimedwait(compat_sigset_t __user *uthese,
-		struct compat_siginfo __user *uinfo,
-		struct compat_timespec __user *uts, compat_size_t sigsetsize);
+
+/* kernel/ptrace.c */
+asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
+				  compat_long_t addr, compat_long_t data);
+
+/* kernel/sched/core.c */
+asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
+				     unsigned int len,
+				     compat_ulong_t __user *user_mask_ptr);
+asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
+				     unsigned int len,
+				     compat_ulong_t __user *user_mask_ptr);
+asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
+						 struct compat_timespec __user *interval);
+
+/* kernel/signal.c */
+asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
+				       compat_stack_t __user *uoss_ptr);
 asmlinkage long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset,
 					 compat_size_t sigsetsize);
-asmlinkage long compat_sys_rt_sigprocmask(int how, compat_sigset_t __user *set,
-					  compat_sigset_t __user *oset,
-					  compat_size_t sigsetsize);
-asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
-					 compat_size_t sigsetsize);
 #ifndef CONFIG_ODD_RT_SIGACTION
 asmlinkage long compat_sys_rt_sigaction(int,
 				 const struct compat_sigaction __user *,
 				 struct compat_sigaction __user *,
 				 compat_size_t);
 #endif
+asmlinkage long compat_sys_rt_sigprocmask(int how, compat_sigset_t __user *set,
+					  compat_sigset_t __user *oset,
+					  compat_size_t sigsetsize);
+asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
+					 compat_size_t sigsetsize);
+asmlinkage long compat_sys_rt_sigtimedwait(compat_sigset_t __user *uthese,
+		struct compat_siginfo __user *uinfo,
+		struct compat_timespec __user *uts, compat_size_t sigsetsize);
 asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
 				struct compat_siginfo __user *uinfo);
+/* No generic prototype for rt_sigreturn */
+
+/* kernel/sys.c */
+asmlinkage long compat_sys_times(struct compat_tms __user *tbuf);
+asmlinkage long compat_sys_getrlimit(unsigned int resource,
+				     struct compat_rlimit __user *rlim);
+asmlinkage long compat_sys_setrlimit(unsigned int resource,
+				     struct compat_rlimit __user *rlim);
+asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
+
+/* kernel/time.c */
+asmlinkage long compat_sys_gettimeofday(struct compat_timeval __user *tv,
+		struct timezone __user *tz);
+asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv,
+		struct timezone __user *tz);
+asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
+
+/* kernel/timer.c */
 asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
-asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
-				 compat_ulong_t arg);
-asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
-		struct compat_timespec __user *utime, u32 __user *uaddr2,
-		u32 val3);
-asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
-				      char __user *optval, int __user *optlen);
-asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
-				      compat_ulong_t nr_segments,
-				      struct compat_kexec_segment __user *,
-				      compat_ulong_t flags);
-asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
-			const struct compat_mq_attr __user *u_mqstat,
-			struct compat_mq_attr __user *u_omqstat);
-asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
-			const struct compat_sigevent __user *u_notification);
+
+/* ipc/mqueue.c */
 asmlinkage long compat_sys_mq_open(const char __user *u_name,
 			int oflag, compat_mode_t mode,
 			struct compat_mq_attr __user *u_attr);
@@ -807,17 +766,92 @@ asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes,
 			char __user *u_msg_ptr,
 			compat_size_t msg_len, unsigned int __user *u_msg_prio,
 			const struct compat_timespec __user *u_abs_timeout);
-asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
-asmlinkage long compat_sys_sysctl(struct compat_sysctl_args __user *args);
+asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
+			const struct compat_sigevent __user *u_notification);
+asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
+			const struct compat_mq_attr __user *u_mqstat,
+			struct compat_mq_attr __user *u_omqstat);
 
-extern ssize_t compat_rw_copy_check_uvector(int type,
-		const struct compat_iovec __user *uvector,
-		unsigned long nr_segs,
-		unsigned long fast_segs, struct iovec *fast_pointer,
-		struct iovec **ret_pointer);
+/* ipc/msg.c */
+asmlinkage long compat_sys_msgctl(int first, int second, void __user *uptr);
+asmlinkage long compat_sys_msgrcv(int msqid, compat_uptr_t msgp,
+		compat_ssize_t msgsz, compat_long_t msgtyp, int msgflg);
+asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
+		compat_ssize_t msgsz, int msgflg);
 
-extern void __user *compat_alloc_user_space(unsigned long len);
+/* ipc/sem.c */
+asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
+asmlinkage long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
+		unsigned nsems, const struct compat_timespec __user *timeout);
+
+/* ipc/shm.c */
+asmlinkage long compat_sys_shmctl(int first, int second, void __user *uptr);
+asmlinkage long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg);
+
+/* net/socket.c */
+asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
+			    unsigned flags, struct sockaddr __user *addr,
+			    int __user *addrlen);
+asmlinkage long compat_sys_setsockopt(int fd, int level, int optname,
+				      char __user *optval, unsigned int optlen);
+asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
+				      char __user *optval, int __user *optlen);
+asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
+				   unsigned flags);
+asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
+				   unsigned int flags);
+
+/* mm/filemap.c: No generic prototype for readahead */
 
+/* security/keys/keyctl.c */
+asmlinkage long compat_sys_keyctl(u32 option,
+			      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
+
+/* arch/example/kernel/sys_example.c */
+asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
+		     const compat_uptr_t __user *envp);
+
+/* mm/fadvise.c: No generic prototype for fadvise64_64 */
+
+/* mm/, CONFIG_MMU only */
+asmlinkage long compat_sys_mbind(compat_ulong_t start, compat_ulong_t len,
+				 compat_ulong_t mode,
+				 compat_ulong_t __user *nmask,
+				 compat_ulong_t maxnode, compat_ulong_t flags);
+asmlinkage long compat_sys_get_mempolicy(int __user *policy,
+					 compat_ulong_t __user *nmask,
+					 compat_ulong_t maxnode,
+					 compat_ulong_t addr,
+					 compat_ulong_t flags);
+asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
+					 compat_ulong_t maxnode);
+asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
+		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
+		const compat_ulong_t __user *new_nodes);
+asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
+				      __u32 __user *pages,
+				      const int __user *nodes,
+				      int __user *status,
+				      int flags);
+
+asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
+					compat_pid_t pid, int sig,
+					struct compat_siginfo __user *uinfo);
+asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+				    unsigned vlen, unsigned int flags,
+				    struct compat_timespec __user *timeout);
+asmlinkage long compat_sys_wait4(compat_pid_t pid,
+				 compat_uint_t __user *stat_addr, int options,
+				 struct compat_rusage __user *ru);
+asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
+					    int, const char __user *);
+asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
+					     struct file_handle __user *handle,
+					     int flags);
+asmlinkage long compat_sys_clock_adjtime(clockid_t which_clock,
+					 struct compat_timex __user *tp);
+asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+				    unsigned vlen, unsigned int flags);
 asmlinkage ssize_t compat_sys_process_vm_readv(compat_pid_t pid,
 		const struct compat_iovec __user *lvec,
 		compat_ulong_t liovcnt, const struct compat_iovec __user *rvec,
@@ -826,14 +860,89 @@ asmlinkage ssize_t compat_sys_process_vm_writev(compat_pid_t pid,
 		const struct compat_iovec __user *lvec,
 		compat_ulong_t liovcnt, const struct compat_iovec __user *rvec,
 		compat_ulong_t riovcnt, compat_ulong_t flags);
+asmlinkage long compat_sys_execveat(int dfd, const char __user *filename,
+		     const compat_uptr_t __user *argv,
+		     const compat_uptr_t __user *envp, int flags);
+asmlinkage ssize_t compat_sys_preadv2(compat_ulong_t fd,
+		const struct compat_iovec __user *vec,
+		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
+asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
+		const struct compat_iovec __user *vec,
+		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
+#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
+asmlinkage long  compat_sys_readv64v2(unsigned long fd,
+		const struct compat_iovec __user *vec,
+		unsigned long vlen, loff_t pos, rwf_t flags);
+#endif
 
-asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
-				    compat_off_t __user *offset, compat_size_t count);
-asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
-				    compat_loff_t __user *offset, compat_size_t count);
-asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
-				       compat_stack_t __user *uoss_ptr);
+#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
+asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
+		const struct compat_iovec __user *vec,
+		unsigned long vlen, loff_t pos, rwf_t flags);
+#endif
+
+
+/*
+ * Architecture-specific system calls
+ */
+
+/* fs/quota/compat.c -- x86 only */
+asmlinkage long compat_sys_quotactl32(unsigned int cmd,
+		const char __user *special, qid_t id, void __user *addr);
+
+/* arch_prctl -- x86 */
+asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);
+
+
+/*
+ * Deprecated system calls which are still defined in
+ * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
+ */
+
+/* __ARCH_WANT_SYSCALL_NO_AT */
+asmlinkage long compat_sys_open(const char __user *filename, int flags,
+				umode_t mode);
+asmlinkage long compat_sys_utimes(const char __user *filename,
+				  struct compat_timeval __user *t);
+
+/* __ARCH_WANT_SYSCALL_NO_FLAGS */
+asmlinkage long compat_sys_signalfd(int ufd,
+				    const compat_sigset_t __user *sigmask,
+				    compat_size_t sigsetsize);
+
+/* __ARCH_WANT_SYSCALL_OFF_T */
+asmlinkage long compat_sys_newstat(const char __user *filename,
+				   struct compat_stat __user *statbuf);
+asmlinkage long compat_sys_newlstat(const char __user *filename,
+				    struct compat_stat __user *statbuf);
+
+/* __ARCH_WANT_SYSCALL_DEPRECATED */
+asmlinkage long compat_sys_time(compat_time_t __user *tloc);
+asmlinkage long compat_sys_utime(const char __user *filename,
+				 struct compat_utimbuf __user *t);
+asmlinkage long compat_sys_futimesat(unsigned int dfd,
+				     const char __user *filename,
+				     struct compat_timeval __user *t);
+asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
+		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+		struct compat_timeval __user *tvp);
+asmlinkage long compat_sys_ustat(unsigned dev, struct compat_ustat __user *u32);
+asmlinkage long compat_sys_recv(int fd, void __user *buf, compat_size_t len,
+				unsigned flags);
+asmlinkage long compat_sys_sysctl(struct compat_sysctl_args __user *args);
+
+/* obsolete: fs/readdir.c */
+asmlinkage long compat_sys_old_readdir(unsigned int fd,
+				       struct compat_old_linux_dirent __user *,
+				       unsigned int count);
+
+/* obsolete: fs/select.c */
+asmlinkage long compat_sys_old_select(struct compat_sel_arg_struct __user *arg);
+
+/* obsolete: ipc */
+asmlinkage long compat_sys_ipc(u32, int, int, u32, compat_uptr_t, u32);
 
+/* obsolete: kernel/signal.c */
 #ifdef __ARCH_WANT_SYS_SIGPENDING
 asmlinkage long compat_sys_sigpending(compat_old_sigset_t __user *set);
 #endif
@@ -842,26 +951,18 @@ asmlinkage long compat_sys_sigpending(compat_old_sigset_t __user *set);
 asmlinkage long compat_sys_sigprocmask(int how, compat_old_sigset_t __user *nset,
 				       compat_old_sigset_t __user *oset);
 #endif
+#ifdef CONFIG_COMPAT_OLD_SIGACTION
+asmlinkage long compat_sys_sigaction(int sig,
+                                   const struct compat_old_sigaction __user *act,
+                                   struct compat_old_sigaction __user *oact);
+#endif
 
-int compat_restore_altstack(const compat_stack_t __user *uss);
-int __compat_save_altstack(compat_stack_t __user *, unsigned long);
-#define compat_save_altstack_ex(uss, sp) do { \
-	compat_stack_t __user *__uss = uss; \
-	struct task_struct *t = current; \
-	put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp), &__uss->ss_sp); \
-	put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
-	put_user_ex(t->sas_ss_size, &__uss->ss_size); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
-} while (0);
-
-asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
-						 struct compat_timespec __user *interval);
+/* obsolete: kernel/time/time.c */
+asmlinkage long compat_sys_stime(compat_time_t __user *tptr);
 
-asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
-					    int, const char __user *);
+/* obsolete: net/socket.c */
+asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
 
-asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);
 
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
-- 
2.16.3

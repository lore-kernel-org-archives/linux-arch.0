Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE9379EFC
	for <linux-arch@vger.kernel.org>; Tue, 16 Jun 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620181; cv=none; b=hc6DlQaijgLyD4ohskVQpj9z0txHrAdYXqzzKy3IFz5aRo/G4gm6lPhZmoGkqCGobAxyo1mWrFDSi1wkBCK2QS2s3Sjt06Tn9l33E0i1a0aqqTujGHx3BzMwwu6zUYBFb+RUd9AsmtUD6p7ikXmC+EkgY6T/Fq1heVnyzso6x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620181; c=relaxed/simple;
	bh=tqi6Sejvg1GHcKTX+qUvnsvBGYUqXJDXs+f0uINE3+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnSiNzPVCVdHDWST3XphufhqELwNlDE88qfQ8ZYRsbUyrYAywbDlKEF80IcCgLl2dekVSVIQrxrQbKjg+xX6gWxvWQGozJyhglprwtBgxcjQkHWH4om8X+U9U3jpOPrmz0RtZRBGnL/eydry9fY0YAlneuRIuxnl+VEvznAQVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=B9cKgWMd; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="B9cKgWMd"
X-KPN-MessageId: ca70d7b8-698f-11f1-8ff8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ca70d7b8-698f-11f1-8ff8-005056999439;
	Tue, 16 Jun 2026 16:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=CDCmQQwu1F9jcH+eIagz+j+kYowcBGg4oXPa2Rq5+to=;
	b=B9cKgWMdFDwOAlxcsm/r5J6HgM7wykc8IJJnOcfNqn60xnAsa3JOKxZwFj8rRS59uCl9r6rt6ANk0
	 YPUMNTD/oZR1j4VbHWQKQv+e68t5Zm1+UYeTnb2C7xpDXjTMw7siSmLmF61iJ8GTodiGLaNi4G8sGj
	 C7vG51+6FLlcHB1U+o8uUNzShYyOipNDffA9EnWCtRtXnyDiyRa9UNF8MErQ6YxlNs8PGLJC7lZZsL
	 8znCREAnGKnFD+Z+tfBvg66Mpwv1Hi6m7XeUffOYf4lH8X3ayIVJsHM8KKIfquEfelZ/1OUtcq45Iu
	 19XUe6Pb4CaUqS8rO7PC4hpU6S+njOQ==
X-KPN-MID: 33|SGkI086mb3E4EDAlUV2Jaa1a+Uz9NcSpefofu1CPsO+awQaX0foHg7Y1JrKyvmW
 Nk69TMIRx7lODaAQDV2ZSOmcG6pR4dbyDOmzeTJsvGEk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xVQALxMoSJqfcOsvYeJnuOVjLTcSCXxDLZGwogphZblcMU/aAat+QxP6kjrwzpb
 0lv109m1dx5tVkxTtOvvALg==
Received: from daedalus.home (unknown [178.230.193.174])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ca0de934-698f-11f1-a77e-00505699772e;
	Tue, 16 Jun 2026 16:29:32 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Willem de Bruijn <willemb@google.com>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 2/4] net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
Date: Tue, 16 Jun 2026 16:30:02 +0200
Message-ID: <20260616143020.3458085-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now if some LSM such as Smack denies an AF_UNIX socket peer to
receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
that point, and MSG_CTRUNC is set on return of recvmsg(). This is
highly problematic behaviour, because it leaves the receiver
wondering what happened. As per man page MSG_CTRUNC is supposed to
indicate that the control buffer was sized too short, but suddenly
a permission error might result in the exact same flag being set.
Moreover, the receiver has no chance to determine how many fds got
originally sent and how many were suppressed.[1]

Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
handling of LSM denials when receiving SCM_RIGHTS messages: instead of
truncating the message at the first blocked fd, keep every fd slot
and store the LSM errno in the blocked slot.

[1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/file.c                         | 48 ++++++++++++++++++++-----------
 include/linux/file.h              |  2 ++
 include/net/af_unix.h             |  1 +
 include/net/scm.h                 | 15 +++++++---
 include/uapi/asm-generic/socket.h |  3 ++
 net/compat.c                      |  4 +--
 net/core/scm.c                    | 13 +++++----
 net/unix/af_unix.c                |  9 ++++++
 8 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..2bc22cc69e84 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1367,6 +1367,25 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	return err;
 }
 
+static int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
+{
+	int error;
+
+	FD_PREPARE(fdf, o_flags, file);
+	if (fdf.err)
+		return fdf.err;
+	get_file(file);
+
+	if (ufd) {
+		error = put_user(fd_prepare_fd(fdf), ufd);
+		if (error)
+			return error;
+	}
+
+	__receive_sock(fd_prepare_file(fdf));
+	return fd_publish(fdf);
+}
+
 /**
  * receive_fd() - Install received file into file descriptor table
  * @file: struct file that was received from another process
@@ -1384,27 +1403,24 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  */
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
-	int error;
-
-	error = security_file_receive(file);
+	int error = security_file_receive(file);
 	if (error)
 		return error;
+	return __receive_fd(file, ufd, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
 
-	FD_PREPARE(fdf, o_flags, file);
-	if (fdf.err)
-		return fdf.err;
-	get_file(file);
-
-	if (ufd) {
-		error = put_user(fd_prepare_fd(fdf), ufd);
-		if (error)
-			return error;
+int receive_fd_filtered(struct file *file, int __user *ufd, unsigned int o_flags,
+		bool *filtered)
+{
+	int error = security_file_receive(file);
+	if (error) {
+		*filtered = true;
+		return error;
 	}
-
-	__receive_sock(fd_prepare_file(fdf));
-	return fd_publish(fdf);
+	*filtered = false;
+	return __receive_fd(file, ufd, o_flags);
 }
-EXPORT_SYMBOL_GPL(receive_fd);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 {
diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d31..748f08470bb4 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -119,6 +119,8 @@ DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 extern void fd_install(unsigned int fd, struct file *file);
 
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
+int receive_fd_filtered(struct file *file, int __user *ufd, unsigned int o_flags,
+		bool *filtered);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 34f53dde65ce..bb1b3dee02e8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -49,6 +49,7 @@ struct unix_sock {
 	struct scm_stat		scm_stat;
 	int			inq_len;
 	bool			recvmsg_inq;
+	bool			scm_rights_notrunc;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	struct sk_buff		*oob_skb;
 #endif
diff --git a/include/net/scm.h b/include/net/scm.h
index c52519669349..761cda0803fb 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -50,8 +50,8 @@ struct scm_cookie {
 #endif
 };
 
-void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
-void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
+void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
+void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
 void __scm_destroy(struct scm_cookie *scm);
 struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
@@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		   struct scm_cookie *scm, int flags);
 
 static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
-				  unsigned int flags)
+				  unsigned int flags, bool notrunc)
 {
+	bool filtered;
+	int error;
+
 	if (!ufd)
 		return -EFAULT;
-	return receive_fd(f, ufd, flags);
+
+	error = receive_fd_filtered(f, ufd, flags, &filtered);
+	if (filtered && notrunc)
+		return put_user(error, ufd);
+	return error;
 }
 
 #endif /* __LINUX_NET_SCM_H */
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 53b5a8c002b1..c5fb2ee96830 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -150,6 +150,9 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_RIGHTS_NOTRUNC	85
+#define SCM_RIGHTS_NOTRUNC	SO_RIGHTS_NOTRUNC
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/compat.c b/net/compat.c
index d68cf9c3aad5..6bdf4a2c9077 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
 	return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / sizeof(int);
 }
 
-void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
+void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 {
 	struct compat_cmsghdr __user *cm =
 		(struct compat_cmsghdr __user *)msg->msg_control_user;
@@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
 		if (err < 0)
 			break;
 	}
diff --git a/net/core/scm.c b/net/core/scm.c
index a73b1eb30fd2..1ef4e9431661 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -351,7 +351,7 @@ static int scm_max_fds(struct msghdr *msg)
 	return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(int);
 }
 
-void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
+void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 {
 	struct cmsghdr __user *cm =
 		(__force struct cmsghdr __user *)msg->msg_control_user;
@@ -365,12 +365,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 		return;
 
 	if (msg->msg_flags & MSG_CMSG_COMPAT) {
-		scm_detach_fds_compat(msg, scm);
+		scm_detach_fds_compat(msg, scm, notrunc);
 		return;
 	}
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
 		if (err < 0)
 			break;
 	}
@@ -542,8 +542,11 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
+	if (scm->fp) {
+		struct unix_sock *u = unix_sk(sock->sk);
+		bool notrunc = READ_ONCE(u->scm_rights_notrunc);
+		scm_detach_fds(msg, scm, notrunc);
+	}
 
 	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0d9cd977c7b7..4e1463ee2815 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -921,6 +921,7 @@ static bool unix_custom_sockopt(int optname)
 {
 	switch (optname) {
 	case SO_INQ:
+	case SO_RIGHTS_NOTRUNC:
 		return true;
 	default:
 		return false;
@@ -956,6 +957,14 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 
 		WRITE_ONCE(u->recvmsg_inq, val);
 		break;
+
+	case SO_RIGHTS_NOTRUNC:
+		if (val > 1 || val < 0)
+			return -EINVAL;
+
+		WRITE_ONCE(u->scm_rights_notrunc, val);
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.54.0


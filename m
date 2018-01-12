From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 10/11] signal: Introduce clear_siginfo
Date: Thu, 11 Jan 2018 18:59:39 -0600
Message-ID: <20180112005940.23279-10-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Unfortunately struct siginfo has holes both in the common part of the
structure, in the union members, and in the lack of padding of the
union members.  The result of those wholes is that the C standard does
not guarantee those bits will be initialized.  As struct siginfo is
for communication between the kernel and userspace that is a problem.

Add the helper function clear_siginfo that is guaranteed to clear all of
the bits in struct siginfo so when the structure is copied there is no danger
of copying old kernel data and causing a leak of information from kernel
space to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 8037b503ce91..87abf0c29ed7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -16,6 +16,11 @@ static inline void copy_siginfo(struct siginfo *to, const struct siginfo *from)
 	memcpy(to, from, sizeof(*to));
 }
 
+static inline void clear_siginfo(struct siginfo *info)
+{
+	memset(info, 0, sizeof(*info));
+}
+
 int copy_siginfo_to_user(struct siginfo __user *to, const struct siginfo *from);
 
 enum siginfo_layout {
-- 
2.14.1

Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268756AbUHTV1u@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:50151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268755AbUHTV1s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 17:27:48 -0400
Date: Fri, 20 Aug 2004 14:31:11 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: copy_mount_options()
Message-Id: <20040820143111.3fd0070e.akpm@osdl.org>
In-Reply-To: <20040820141137.646c349f.davem@redhat.com>
References: <20040820130110.07f7c23c.davem@redhat.com>
	<20040820131053.3d5e0f9b.akpm@osdl.org>
	<20040820141137.646c349f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@redhat.com> wrote:
>
> On Fri, 20 Aug 2004 13:10:53 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > For some reason, copy_mount_options() is a continual pain in the ass.  It
> > just comes up again and again.
> > 
> > For this problem I'd suggest we just rip the copy_from_user() out of there
> > and rewrite the function to use byte-at-a-time get_user()s.
> 
> I totally agree.

Something like this?

--- 25/fs/namespace.c~copy_mount_options-size-fix	Fri Aug 20 14:25:39 2004
+++ 25-akpm/fs/namespace.c	Fri Aug 20 14:30:09 2004
@@ -930,7 +930,29 @@ void mark_mounts_for_expiry(struct list_
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
 
-int copy_mount_options (const void __user *data, unsigned long *where)
+/*
+ * Some copy_from_user() implementations do not return the exact number of
+ * bytes remaining to copy on a fault.  But copy_mount_options() requires that.
+ */
+
+static long
+exact_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	char *t = to;
+	const char __user *f = from;
+	char c;
+
+	while (n) {
+		if (get_user(c, f))
+			break;
+		*t++ = c;
+		f++;
+		n--;
+	}
+	return n;
+}
+
+int copy_mount_options(const void __user *data, unsigned long *where)
 {
 	int i;
 	unsigned long page;
@@ -952,7 +974,7 @@ int copy_mount_options (const void __use
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-	i = size - copy_from_user((void *)page, data, size);
+	i = size - exact_copy_from_user((void *)page, data, size);
 	if (!i) {
 		free_page(page); 
 		return -EFAULT;
_

Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:29108 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266108AbUFEAaX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2004 20:30:23 -0400
Date: Fri, 4 Jun 2004 17:28:16 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: sys getdents64 needs compat wrapper ?
Message-Id: <20040604172816.259f38e8.davem@redhat.com>
In-Reply-To: <40C110C9.2060900@intel.com>
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de>
	<40C110C9.2060900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Some bug fixes needed:

+#define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))

Cast must be "(char __user *)" to avoid sparse warnings.

+	if (__put_user(d_type, (char *) dirent + reclen - 1))

Again need "(char __user *)" for sparse.

+		if ((__put_user(offset, (u32 *)&dirent->d_off))
+		 || (__put_user(offset >> 32, ((u32 *)&dirent->d_off) + 1)))

Again, need "(u32 __user *)"

	 || (__put_user(ino >> 32, ((u32 *)&dirent->d_ino) + 1)))

Another "(u32 __user *)"

+	 || (__put_user(off >> 32, ((u32 *)&dirent->d_off) + 1)))

Another "(u32 __user *)"

+		__put_user(d_off, (u32 *)&lastdirent->d_off);
+		__put_user(d_off >> 32, ((u32 *)&lastdirent->d_off) + 1);

Two more "(u32 __user *)"

People really need to get into the habit of running sparse on their
changes to the compat code now that we've annotated most of it. :-)

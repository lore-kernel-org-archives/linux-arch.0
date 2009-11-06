From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/11] generic compat_sys_sysctl
Date: Fri, 6 Nov 2009 11:27:24 +0100
Message-ID: <200911061127.25337.arnd@arndb.de>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:64963 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164AbZKFK3R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2009 05:29:17 -0500
In-Reply-To: <m1tyx8trik.fsf@fess.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Thibaut Varene <T-Bone@parisc-linux.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Friday 06 November 2009, Eric W. Biederman wrote:
> current architecture name for it's 32bit compat syscall with
> compat_sys_sysctl, and deleting the architectures private
> 32bit compat syscall.  The only requirement is that CONFIG_COMPAT
> be set when you need compat_sys_sysctl.
> 
> These patches should just work, but an eyeball from someone who is
> familiar with the architecture specific details would be appreciated.
> I have only tested the 32bit compat code on x86_64.

I have done similar conversions for other syscalls and am familiar
with s390 and powerpc specific details. Your compat code looks good
for all of the pitfalls I'm aware of and possibly fixes bugs in the
existing arch specific implementations.

Very nice series!

Acked-by: Arnd Bergmann <arnd@arndb.de>

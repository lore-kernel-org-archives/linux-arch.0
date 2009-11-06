From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 0/11] generic compat_sys_sysctl
Date: Thu, 05 Nov 2009 16:40:19 -0800
Message-ID: <m1tyx8trik.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:45880 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759181AbZKFAke (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2009 19:40:34 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Thibaut Varene <T-Bone@parisc-linux.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>


I am in the process of cleaning up, and converting the binary sysctl
sysctl call into a wrapper on top of the text based proc/sys.

A first step in that process is to introduce a generic
compat_sys_sysctl to reduce the number of places I have to touch.
The following patcheset is the start of my series for handling that.

The only architecture specific changes should be replace the
current architecture name for it's 32bit compat syscall with
compat_sys_sysctl, and deleting the architectures private
32bit compat syscall.  The only requirement is that CONFIG_COMPAT
be set when you need compat_sys_sysctl.

These patches should just work, but an eyeball from someone who is
familiar with the architecture specific details would be appreciated.
I have only tested the 32bit compat code on x86_64.

Eric

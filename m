Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbfEIKrG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 May 2019 06:47:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49ARUhA116823
        for <linux-arch@vger.kernel.org>; Thu, 9 May 2019 06:47:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2scgtw5wyy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2019 06:47:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 9 May 2019 11:47:03 +0100
Date: Thu, 9 May 2019 12:46:58 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Early printk breakage due to 3e5903eb9cff ("vsprintf: Prevent crash
 when dereferencing invalid pointers")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190509104658.GB5758@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20190509104658.f_2EwEmjZL26IziqPt5hEc_R5HdcMxUpORi7d1fmB-4@z>

Hello Petr,

I just realized that early printks, or more specific vsnprintf invocations,
are broken on s390 due to

3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers").

E.g. the early boot output now looks like this where the first
(efault) should be the linux_banner:

[    0.099985] (efault)
[    0.099985] setup: Linux is running as a z/VM guest operating system in 64-bit mode
[    0.100066] setup: The maximum memory size is 8192MB
[    0.100070] cma: Reserved 4 MiB at (efault)
[    0.100100] numa: NUMA mode: (efault)

The reason for this, is that your code assumes that
probe_kernel_address() works very early. This however is not true on
at least s390. Uaccess on KERNEL_DS works only after page tables have
been setup on s390, which happens with setup_arch()->paging_init().

Any probe_kernel_address() invocation before that will return -EFAULT.

So how should we fix this? We could e.g. again add an arch specific
version of probe_kernel_read() for s390, which would be more or less a
copy of the generic variant, just that it would do something different
if page tables aren't setup yet.

Or... any other idea?

Cc'ing linux-arch, just in case other architectures are also affected.

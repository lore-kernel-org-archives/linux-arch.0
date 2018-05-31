Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754641AbeEaKpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 31 May 2018 06:45:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VAj3HI015171
        for <linux-arch@vger.kernel.org>; Thu, 31 May 2018 06:45:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jacpf75bb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 31 May 2018 06:45:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 31 May 2018 11:44:07 +0100
Date: Thu, 31 May 2018 16:13:58 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v4 00/27] kprobes: Cleanup jprobe implementation
References: <152749074878.15132.16693721906742461289.stgit@devbox>
        <20180530180108.e3a7a37672e65d5ee685596f@kernel.org>
In-Reply-To: <20180530180108.e3a7a37672e65d5ee685596f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Message-ID: <1527763318.89hbp0ia4a.naveen@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H . Peter Anvin" <hpa@zytor.com>, Josef Bacik <jbacik@fb.com>, James Hogan <jhogan@kernel.org>, Laura Abbott <labbott@redhat.com>, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20180531104358.zYS4tHeiTp5a00UmI9s0j4IU-UpeT2c5mSGMOgvsAE8@z>

Hi Masami,

Masami Hiramatsu wrote:
> Hi Naveen,
> 
> Sorry, I might miss to add you on CC list. Could you test and review this on powerpc?

Sure, thanks for letting me know. If possible, please mark powerpc 
patches to linuxppc-dev@lists.ozlabs.org  so that it gets good review.

- Naveen

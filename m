Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44503 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754424AbdCBJBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 04:01:34 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v227SwgN086734
        for <linux-arch@vger.kernel.org>; Thu, 2 Mar 2017 02:34:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrc30ee-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 02 Mar 2017 02:34:39 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 2 Mar 2017 07:34:36 -0000
Date: Thu, 2 Mar 2017 08:34:26 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCHv2 00/14] set_memory_* functions header refactor
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <20170302073426.GA7265@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170302073426.TgrSR44kG5fCjFpQuWy1KYB0HFme0-sbgQTA7UICpyY@z>

On Wed, Mar 01, 2017 at 04:14:52PM -0800, Laura Abbott wrote:
> Hi,
> 
> This is v2 of my proposal to move set_memory_* function prototypes out of
> cacheflush.h and into their own header file. This came out of a comment
> Russell made while reviewing RODATA test cases
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> While the final result of that series was the rodata code was refactored into
> its own header file, the set_memory_* APIs are still out of place.
> 
> This version refactored the common set_memory_* functions into an asm-generic
> header. s390x added some features so it can't just use the asm-generic header.
> I debated how much more to try and shove into the asm-generic version (e.g.
> stub prototypes for the ARM nommu case, set_kernel_text_*) but decided to stick
> with just the basics for this version.
> 
> I split out the cacheflush.h -> set_memory.h conversions into separate patches
> to hopefully make merging easier. Worst case, the final patch to completely
> separate the two can be delayed if there are more problems found. I'd like
> for this to eventually go through the -mm tree so I'd like Acks where
> appropriate.
> 
> As always, feedback appreciated.

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

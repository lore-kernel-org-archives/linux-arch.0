From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 15:41:37 -0400
Message-ID: <389f79f9-f1a5-963e-dd05-4d0aaabb5346@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:56088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaTmg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 15:42:36 -0400
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 7/27/2020 1:11 PM, Anthony Yznaga wrote:
> This patchset adds support for preserving an anonymous memory range across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> sharing memory in this manner, as opposed to re-attaching to a named shared
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address,
> vfio mappings and their associated kernel data structures can remain valid.
> In addition, for the qemu use case, qemu instances that back guest RAM with
> anonymous memory can be updated.

I forgot to mention, our use case is not just theoretical.  It has been implemented
and is pretty cool (but I am biased).  The pause time for the guest is in the
100 - 200 msec range.  We submitted qemu patches for review based on the MADV_DOEXEC
proposal.  In case you are curious:
  https://lore.kernel.org/qemu-devel/1596122076-341293-1-git-send-email-steven.sistare@oracle.com/

- Steve

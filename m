From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 15/29] nios2: System calls handling
Date: Mon, 21 Jul 2014 19:17:42 +0800
Message-ID: <CAFiDJ59Aj9Hdp3C9d-2XhUdCGVwn9aYm2yY=sUHDCZFCv8XhOw@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-16-git-send-email-lftan@altera.com>
	<53C9198B.1020808@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53C9198B.1020808@imgtec.com>
Sender: linux-doc-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Arnd <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 18, 2014 at 8:56 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi,
>
> On 15/07/14 09:45, Ley Foon Tan wrote:
>> This patch adds support for system calls from userspaces. It uses the
>> asm-generic/unistd.h definitions with architecture spcific syscall. The sys_call_table
>> is just an array defined in a C file and it contains pointers to the syscall functions.
>
> I don't think you need the renameat syscall now that renameat2 exists.
>
> Can I suggest preceding your patchset with this patch:
> https://lkml.org/lkml/2014/4/23/197
> ([RFC 3/3] asm-generic: Drop renameat syscall from default list)
>
> which drops renameat from the generic list unless __ARCH_WANT_RENAMEAT
> is defined in the arch's uapi/asm/unistd.h.
Yes, we don't need renameat syscall. Will add this patch.

Thanks.

Regards
Ley Foon

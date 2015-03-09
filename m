Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36359 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbbCIRH6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 13:07:58 -0400
Received: by wiwh11 with SMTP id h11so12553478wiw.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Mar 2015 10:07:57 -0700 (PDT)
Message-ID: <54FDD2D8.8090509@vanguardiasur.com.ar>
Date: Mon, 09 Mar 2015 14:05:28 -0300
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Subject: Re: nios2: is the ptrace ABI correct?
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <10088870.tldQegtTla@wuerfel> <54EDB2FC.4050901@vanguardiasur.com.ar> <10841724.NbdcAaCe1a@wuerfel> <54F03184.7080600@codesourcery.com> <54F052B1.4070300@vanguardiasur.com.ar> <54FDD041.3080500@codesourcery.com> <54FDD219.1060707@gmail.com>
In-Reply-To: <54FDD219.1060707@gmail.com>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chung-Lin Tang <chunglin.tang@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>, Tobias Klauser <tklauser@distanz.ch>, Ley Foon Tan <lftan@altera.com>
Cc: Walter Goossens <waltergoossens@home.nl>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150309170528.l-gwHGZ23yCkWdx19Q74U6BGhEpyWj9XzzbXRKfRc4A@z>



On 03/09/2015 02:02 PM, Chung-Lin Tang wrote:
> On 2015/3/10 12:54 AM, Chung-Lin Tang wrote:
>> It appears that some of the ways nios2 has organized the
>> ucontext/pt_regs/etc. are remnants of the pre-generic code, some
>> basically because the port was based off m68k.
>>
>> I've re-organized the headers a bit: nios2/include/asm/ucontext.h is
>> deleted, and re-definition of struct sigcontext now allows use of
>> uapi/asm-generic/ucontext.h directly.  Note that the reorg, despite
>> effectively renaming some fields, is still binary compatible. I'll
>> probably update the corresponding glibc definitions later.
>>
>> struct pt_regs is now not exported, and all exported register sets are
>> now supposed to follow the 49 register set defined as in GDB now.
>>
>> Tobias, Ley Foon, how do you think this looks?
> 
> Sorry, accidentally attached unrelated GCC patch instead, this one's the
> correct one.
> 

Looks good. I'm wondering if...

+/* User structures for general purpose registers.  */
+struct user_pt_regs {
+	__u32		regs[49];
 };

Can we expose the registers explicitly here? Like this:

struct user_pt_regs {
	__u32 r0;
	__u32 r1;
	...
	__u32 sp;
	__u32 gp;
	__u32 estatus;
};

It looks self-documenting and thus easier to use.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar

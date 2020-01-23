From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
Date: Thu, 23 Jan 2020 13:23:35 -0800
Message-ID: <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
 <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
 <20200123202600.GG10328@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123202600.GG10328@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

On 1/23/20 12:26 PM, Borislav Petkov wrote:
> On Thu, Jan 23, 2020 at 11:26:38AM -0800, Linus Torvalds wrote:
>> On Thu, Jan 23, 2020 at 11:23 AM Dave Hansen
>> <dave.hansen@linux.intel.com> wrote:
>>> I'd _rather_ this go in via the x86 tree, but I'm not picky.
> Any particular reason why?

I'm confident I can send patches to the x86 maintainers and not make
them too angry.  Sending pull requests to Linus, not so much. :)

I'll just plan to send it to Linus directly.

From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 13/25] mips: Use Kbuild infrastructure to handle asm-generic
 headers
Date: Mon, 2 Sep 2013 09:55:57 +0100
Message-ID: <5224529D.10009@imgtec.com>
References: <20121013022632.024527228@goodmis.org> <20121013022954.289710602@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121013022954.289710602@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On 13/10/12 03:26, Steven Rostedt wrote:
> From: Steven Rostedt <srostedt@redhat.com>
> 
> Use Kbuild infrastructure to handle the asm-generic headers
> and remove the wrapper headers that call them.
> 
> This only affects headers that do nothing but include the generic
> equivalent. It does not touch any header that does a little more.

Hi Steven,

Please see "MIPS: use generic-y where possible" already queued in -next.
cad3b624853b6f34f19693b9812df0d473a6fd40
https://patchwork.linux-mips.org/patch/5581/

Also note, as I said in the commit message:
>     We can't do the same for uapi/asm/kvm_para.h because it's presence is
>     explicitly checked in include/uapi/linux/Kbuild to decide whether to add
>     kvm_para.h to header-y.

so I guess that may need fixing first before half of these patches can
be accepted.

Cheers
James

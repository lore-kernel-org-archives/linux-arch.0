From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
Date: Tue, 24 Apr 2018 10:32:53 +0200
Message-ID: <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2018 at 6:06 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
> On 04/20/18 15:38, Eric W. Biederman wrote:
>>
>> Today user mode linux only works on x86 and x86_64 and this allows
>> simplifications of relay_signal.
>
>
> I believe someone recently fixed the ARM port. I have not had the time to
> try the fixes though.

Huh? UML is for ages x86 only.

-- 
Thanks,
//richard

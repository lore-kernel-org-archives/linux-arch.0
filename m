From: =?UTF-8?Q?Martin_P=C3=A4rtel?= <martin.partel@gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
Date: Thu, 26 Apr 2018 02:05:44 +0300
Message-ID: <CAMD8JhxzzCCjo_OLs8wS7ggOh4NqdxeRAGhcvuEJSUZZLO6NDA@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk> <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
 <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk> <87zi1sd28d.fsf@xmission.com>
 <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
 <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com> <87lgdc1bvr.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lgdc1bvr.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

>
> Then my analysis is correct that you simply missed filtering out the
> si codes that are not signal specific and do not use the fault layout
> in struct siginfo.
> ...
> I would say that you really need a
> white-list of si_codes that whose use of struct siginfo that you know.
> Otherwise you could get into the same problem of under or over copying
> data.
>

I think that's correct, but I'm not super familiar with either UML or
signal handling.

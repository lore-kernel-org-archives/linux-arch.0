From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] OpenRISC architecture
Date: Sat, 23 Jul 2011 14:17:00 -0700
Message-ID: <CA+55aFwy-oWnJ1Mp_7m-Myrfm_W3cysacirRhjXohxzQyTgK8Q@mail.gmail.com>
References: <1311408223.3499.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42938 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751374Ab1GWVRW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 23 Jul 2011 17:17:22 -0400
In-Reply-To: <1311408223.3499.13.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Jul 23, 2011 at 1:03 AM, Jonas Bonn <jonas@southpole.se> wrote:
>
> NOTE: =A0This pull depends on a patch "modules: add default loader ho=
ok
> implementations" in Rusty's tree... without that, the OpenRISC arch w=
ill
> not build. =A0Note also that there are a couple of patches that touch
> asm-generic bits at the base of the branch, including a patch from
> Andrew that was moved to this branch to avoid a merge conflict.

So I don't want to pull this if it doesn't build. Rusty, what's the
status of your module tree?

                    Linus

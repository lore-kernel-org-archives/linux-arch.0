From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/5] blackfin: Convert BUG() to use
	unreachable()
Date: Thu, 10 Dec 2009 17:42:37 -0500
Message-ID: <8bd0f97a0912101442kfeb360cvf529321679ff1b2e@mail.gmail.com>
References: <4B212EEC.3060808@caviumnetworks.com> <1260466101-17545-5-git-send-email-ddaney@caviumnetworks.com>
	<8bd0f97a0912101333x2ba210d8ib1936bffa0ef2d7b@mail.gmail.com>
	<4B2169A8.5080503@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51447 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762003AbZLJWmu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 17:42:50 -0500
In-Reply-To: <4B2169A8.5080503@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, uclinux-dist-devel@blackfin.uclinux.org

On Thu, Dec 10, 2009 at 16:35, David Daney wrote:
> Mike Frysinger wrote:
>> On Thu, Dec 10, 2009 at 12:28, David Daney wrote:
>>> Use the new unreachable() macro instead of for(;;);
>>
>> sorry, i guess i missed this back in Sept. =C2=A0change looks fine t=
o me
>> (i'll test it later when finishing putting together other patches).
>> you want me to push though my queue ? =C2=A0doesnt matter to me.
>
> Yes, if you test it and are happy with it. =C2=A0I have no queue and =
plan no
> further action.

rgr
-mike

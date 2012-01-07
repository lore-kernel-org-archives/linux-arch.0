From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] driver core merge for 3.3
Date: Sat, 7 Jan 2012 11:29:09 -0800
Message-ID: <CA+55aFxzx0Z7QKXE9xzOcY3WOtAs18MPkP9kfT3tk1sNTgWrHw@mail.gmail.com>
References: <20120106201126.GA7239@kroah.com> <CAMuHMdVdTcJFePA2tf-jqnLGW_2i7rJLqAX521SM+rz0YzXJNg@mail.gmail.com>
 <20120106220608.GA20623@suse.de> <20120106223148.GN20752@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58463 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab2AGT3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2012 14:29:32 -0500
In-Reply-To: <20120106223148.GN20752@decadent.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg KH <gregkh@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Jan 6, 2012 at 2:31 PM, Ben Hutchings <ben@decadent.org.uk> wro=
te:
>
> It works just fine on UP x86. =A0However I have been made aware that
> it breaks on m68k and I told you as much in
> <1325462025.13595.189.camel@deadeye>:
>
>> None of these architectures appears to call register_cpu():
>>
>> =A0 =A0 c6x frv h8300 m68k microblaze openrisc score um xtensa
>>
>> and therefore they will all panic at boot following this change (com=
mit
>> ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b). =A0So either I can try to=
 fix
>> them or else it must be reverted for now.

Ok, let's try to move forward, and just have those architectures add
the appropriate "register_cpu()" calls. I can live with them breaking
for a short while, and hopefully me merging this will result in it
quickly being fixed.

                      Linus

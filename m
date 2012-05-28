From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Sun, 27 May 2012 20:47:11 -0700
Message-ID: <CA+55aFyKG15oS4pMMTPTNjberaeXjhbXZr9RnszNJb-5sjtKZQ@mail.gmail.com>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
 <20120525.224318.1418525735588086513.davem@davemloft.net> <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
 <20120526.001552.1171433126500742038.davem@davemloft.net> <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
 <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
 <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com> <20120528030726.GC6822@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58723 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab2E1Drc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2012 23:47:32 -0400
Received: by wibhn6 with SMTP id hn6so1300919wib.1
        for <linux-arch@vger.kernel.org>; Sun, 27 May 2012 20:47:31 -0700 (PDT)
In-Reply-To: <20120528030726.GC6822@bloggs.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Jonas Bonn <jonas@southpole.se>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

On Sun, May 27, 2012 at 8:07 PM, Paul Mackerras <paulus@samba.org> wrot=
e:
>
> Apart from a thinko in the aligned_byte_mask definition (it's wrong
> for 32-bit big-endian), it looks fine. =A0You're right about it not
> getting very far at all; my 32-bit powerbook couldn't even mount
> root. =A0I have sent a patch for that and one to use this stuff on
> powerpc - without Ben's ack since he is off sick at the moment.

Ahh. OpenRISC is 64-bit, and apparently David never tested 32-bit
sparc. I'd tested it on both x86-63 and i386, but those obviously
wouldn't have shown any big-endian issues.

Thanks,

                    Linus

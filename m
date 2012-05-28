From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Sun, 27 May 2012 20:53:47 -0700
Message-ID: <CA+55aFzTTNM+v7R8ZScizZoeMisNa9D9BngEysZphUthXr4h+A@mail.gmail.com>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
 <20120525.224318.1418525735588086513.davem@davemloft.net> <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
 <20120526.001552.1171433126500742038.davem@davemloft.net> <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
 <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
 <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
 <20120528030726.GC6822@bloggs.ozlabs.ibm.com> <CA+55aFyKG15oS4pMMTPTNjberaeXjhbXZr9RnszNJb-5sjtKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:45305 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2E1DyJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2012 23:54:09 -0400
Received: by wgbds11 with SMTP id ds11so1098860wgb.1
        for <linux-arch@vger.kernel.org>; Sun, 27 May 2012 20:54:07 -0700 (PDT)
In-Reply-To: <CA+55aFyKG15oS4pMMTPTNjberaeXjhbXZr9RnszNJb-5sjtKZQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Jonas Bonn <jonas@southpole.se>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

On Sun, May 27, 2012 at 8:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ahh. OpenRISC is 64-bit

oops, no it isn't. But apparently the test coverage is crap ;_)

            Linus

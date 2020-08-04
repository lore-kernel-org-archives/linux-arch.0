From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
Date: Tue, 4 Aug 2020 14:52:05 +0200
Message-ID: <CAKgNAkhrjuAXOey2Mp64oitqyjyTu1Zbtx0dy5J2-qzpyFf33Q@mail.gmail.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
 <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com> <20200720165205.GI30452@arm.com>
 <CAKgNAkggayFEjHgPNu1HzvXGfSDoCq=Y-Ni4iv=RBYk2Eb6U1Q@mail.gmail.com> <20200729145630.GH21941@arm.com>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHDMwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 08:52:18 -0400
In-Reply-To: <20200729145630.GH21941@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

> > >         There is already inconsistency here: there are may top-level
> > >         lists using ".IP *" in prctl.2, and plenty of places where the
> > >         default indentation is used.
> >
> > I must admit that I'm in the process of rethinking bulleted lists, and
> > I have not come to a conclusion (and that's why nothing is said in
> > man-pages(7), and also why there is currently inconsistency).
> >
> > Using .IP with the default indent (8n) results in a very deep indent
> > between the glyph and the text, so it's not my preference.
>
> Is it worth trying to change the default indent in the macro package, or
> will that just upset other people?

I imagine it would break other stuff.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

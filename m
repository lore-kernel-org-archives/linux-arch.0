Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:33840 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeJKXVA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Oct 2018 19:21:00 -0400
Date: Fri, 12 Oct 2018 02:52:32 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
In-Reply-To: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810120252220.20563@namei.org>
References: <20181011001846.30964-1-keescook@chromium.org> <alpine.LRH.2.21.1810111443500.25845@namei.org> <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181011155232.A9qIqRslkN213xBRAr19d9TGt0A6somYsaQy9N28d0M@z>

On Thu, 11 Oct 2018, Kees Cook wrote:

> On Wed, Oct 10, 2018 at 8:45 PM, James Morris <jmorris@namei.org> wrote:
> > On Wed, 10 Oct 2018, Kees Cook wrote:
> >
> >> v5:
> >> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
> >> - dropped various Reviewed-bys due to rather large refactoring
> >
> > Patches 1-10 applied to
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> > and next-testing.
> 
> Very cool; thanks!
> 
> As for the rest, I could post some examples of how the new CONFIG_LSM
> and "lsm=..." work (and how they mix with the "legacy" options). Would
> that be helpful?

Yes, thanks.

-- 
James Morris
<jmorris@namei.org>

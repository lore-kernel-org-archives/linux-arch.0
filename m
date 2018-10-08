From: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Mon, 8 Oct 2018 10:25:59 -0400
Message-ID: <CAHC9VhSgy2UXB4q0qLr-qeRwqiO=Zm9mpJdUDWdvtRM17JUhbg@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov> <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
 <638db305-cfef-4391-90bf-458f50c4612f@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <638db305-cfef-4391-90bf-458f50c4612f@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john.johansen@canonical.com, keescook@chromium.org, casey@schaufler-ca.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>, Golden_Miller83@protonmail.ch, penguin-kernel@i-love.sakura.ne.jp, casey.schaufler@intel.com, linux-security-module@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 4, 2018 at 1:38 AM John Johansen
<john.johansen@canonical.com> wrote:
> On 10/03/2018 10:26 AM, Kees Cook wrote:

...

> > Either a distro builds a very specific subset of LSMs, or they build
> > in all LSMs (for the user to choose from). In both cases, they set an
> > explicit order, which defines which exclusive LSM get selected.
>
> and when lsm stacking lands, that exlusive LSM goes away.

FWIW, I still believe in my earlier statements supporting explicitly
enabling LSM stacking via Kconfig.

-- 
paul moore
www.paul-moore.com

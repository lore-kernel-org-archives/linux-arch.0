From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 02/11] mm: Hardened usercopy
Date: Wed, 20 Jul 2016 20:24:43 +1000
Message-ID: <1469010283.2800.5.camel@gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
	 <1468619065-3222-3-git-send-email-keescook@chromium.org>
	 <fc3c7f68-bd2e-cb06-c47c-d97c520fc08b@redhat.com>
	 <CAGXu5j+nHpHcYT8FyHNe6AFQCdakoSMW=UWDatyxhRK7CB7_=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAGXu5j+nHpHcYT8FyHNe6AFQCdakoSMW=UWDatyxhRK7CB7_=g@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Micay <danielmicay@gmail.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S.
 Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Bori
List-Id: linux-arch.vger.kernel.org

On Tue, 2016-07-19 at 11:48 -0700, Kees Cook wrote:
> On Mon, Jul 18, 2016 at 6:06 PM, Laura Abbott <labbott@redhat.com> wrot=
e:
> >=C2=A0
> > On 07/15/2016 02:44 PM, Kees Cook wrote:
> >=C2=A0
> > This doesn't work when copying CMA allocated memory since CMA purpose=
ly
> > allocates larger than a page block size without setting head pages.
> > Given CMA may be used with drivers doing zero copy buffers, I think i=
t
> > should be permitted.
> >=C2=A0
> > Something like the following lets it pass (I can clean up and submit
> > the is_migrate_cma_page APIs as a separate patch for review)
> Yeah, this would be great. I'd rather use an accessor to check this
> than a direct check for MIGRATE_CMA.
>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (; ptr <=3D end ;=
 ptr +=3D PAGE_SIZE, page =3D virt_to_head_page(ptr))
> > {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!PageReserved(page))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!PageReserved(page) && !is_migrate_cma_page(page=
))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return "<spans multiple pages>";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> Yeah, I'll modify this a bit so that which type it starts as is
> maintained for all pages (rather than allowing to flip back and forth
> -- even though that is likely impossible).
>=C2=A0
Sorry, I completely missed the MIGRATE_CMA bits. Could you clarify if you
caught this in testing/review?

Balbir Singh.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>

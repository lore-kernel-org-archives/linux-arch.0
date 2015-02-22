From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Mon, 23 Feb 2015 10:50:52 +1100
Message-ID: <1424649052.4980.17.camel@au1.ibm.com>
References: <1422361485.6648.71.camel@opensuse.org>
	 <54C78756.9090605@suse.cz>
	 <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	 <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
	 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	 <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
	 <CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
	 <CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
	 <1422836637.17302.9.camel@au1.ibm.com>
	 <CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <opensuse-factory+bounces-58789-glsod-opensuse-factory=m.gmane.org@opensuse.org>
In-Reply-To: <CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
List-Post: <mailto:opensuse-factory@opensuse.org>
List-Help: <mailto:opensuse-factory+help@opensuse.org>
List-Subscribe: <mailto:opensuse-factory+subscribe@opensuse.org>
List-Unsubscribe: <mailto:opensuse-factory+unsubscribe@opensuse.org>
List-Owner: <mailto:opensuse-factory+owner@opensuse.org>
List-Archive: <http://lists.opensuse.org/opensuse-factory/>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Takashi Iwai <tiwai@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>
List-Id: linux-arch.vger.kernel.org

On Sun, 2015-02-01 at 17:09 -0800, Linus Torvalds wrote:
> On Sun, Feb 1, 2015 at 4:23 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> >
> > I prefer having the test inside mm_fault_error(), even if that makes the
> > patch a bit bigger, it keeps the logic in a single place. Untested
> > patch:
> 
> I'm certainly ok with that, but I wanted to make the code that I
> wasn't going to compile (much less test) for various architectures be
> as simple and straightforward as possible.

Ah, I missed your reply ... my fault for using the wrong email address
to send my message in the first place :-)

> So feel free to send a patch that fixes it up to do it in a single
> place after testing it.

Ok sure, I'll have a look in the next few days, bogged down with some
local emergency right now.

> Of course, what I *really* want would be to make a new
> "generic_mm_fault()" helper that would do all the normal stuff:
> 
>  - find_vma()
>  - check permissions and ranges
>  - call 'handle_mm_fault()'
>  - do the proper error, retry and minor/major fault handling
> 
> and then most architectures could just call that.

That would be great ...

> Anybody willing to see if they could encapsulate that part of the x86
> code, and make it more widely useful? I say "x86 code", because that's
> the most tested one, and I think it gets the odd retry and error cases
> right (and minor/major fault counting etc), unlike some.

I can try to give it a spin some time this week I think, I can probably
do x86, powerpc and arm. Let's see if I manage to not forget :)

Cheers,
Ben.


>                            Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
To unsubscribe, e-mail: opensuse-factory+unsubscribe@opensuse.org
To contact the owner, e-mail: opensuse-factory+owner@opensuse.org

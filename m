From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/4] huge vmalloc mappings
Date: Tue, 14 Apr 2020 22:23:11 +1000
Message-ID: <1586866432.g0r7udmtjr.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <alpine.DEB.2.21.2004131727150.260270@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.2004131727150.260270@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Excerpts from David Rientjes's message of April 14, 2020 10:27 am:
> On Mon, 13 Apr 2020, Nicholas Piggin wrote:
>=20
>> We can get a significant win with larger mappings for some of the big
>> global hashes.
>>=20
>> Since RFC, relevant architectures have added p?d_leaf accessors so no
>> real arch changes required, and I changed it not to allocate huge
>> mappings for modules and a bunch of other fixes.
>>=20
>=20
> Hi Nicholas,
>=20
> Any performance numbers to share besides the git diff in the last patch i=
n=20
> the series?  I'm wondering if anything from mmtests or lkp-tests makes=20
> sense to try?

Hey, no I don't have any other tests I've run. Some of the networking
hashes do make use of it as well though, and might see a few % in
the right kind of workload. There's probably a bunch of other stuff
where it could help a little bit, looking through the tree, I just don't
have anything specific.

Thanks,
Nick

From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] asm-generic/io.h: Fix io{read,write}{16,32}be for big
 endian systems
Date: Tue, 18 Jan 2011 20:01:12 +0100
Message-ID: <4D35E378.70300@metafoo.de>
References: <1295374261-19609-1-git-send-email-lars@metafoo.de> <201101181944.07146.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101181944.07146.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/18/2011 07:44 PM, Arnd Bergmann wrote:
> On Tuesday 18 January 2011 19:11:01 Lars-Peter Clausen wrote:
>> Currently io{read,write}{16,32} expand to
>>         *addr = cpu_to_leXX(cpu_to_beXX(val))
>> and
>>         val = beXX_to_cpu(leXX_to_cpu(*addr))
>>
>> While it should rather be:
>>         *addr = cpu_to_be{16,32}(val)
>> and
>>         val = be{16,32}_to_cpu(*addr)
>>
>> The current implementation works on litte-endian targets(where cpu_to_leXX is a
>> noop), but breaks on on big-endian targets, this patch fixes it.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> The existing code looks broken on big-endian indeed, thanks
> for the report!
> 
> However, you cannot use __raw_readl in general, because that
> function knows nothing about the various kinds of I/O accesses
> (potentially) handled by readl. Think of architectures where
> readl is not a pointer dereference but something else.

Well, i've though about that as well, but in the current asm-generic/io.h readl is
unconditionally defined as cpu_to_le32(__raw_readl(addr)) and ioread32 is defined as
readl.

So unless an arch io.h undefines those macros and redefines them (which none of the
current archs does, as far as i can see), we are o

If an arch chooses to redefine ioread or readl, it should probably also redefine
ioread{16,32}be.

> 
> The right solution is probably to use swab16/swab32 for the
> big-endian functions. This also corrects the iowrite functions
> which really should be using cpu_to_be32 instead of be32_to_cpu
> (although they are always defined to be the same afaict.

This would first cause a conversion to little-endian, which is a swap() in the
generic case and then you would call swap() again on the result. Which is basically a
noop, but I'm not sure if compilers will detect this.

> 
> 	Arnd

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0143gACgkQBX4mSR26RiPJwACgh1KJKR6o5X/kazS34g/stGKq
OQ4AniZR7SlxTzpJDz7xTvPfeqAqH3S6
=Q6cD
-----END PGP SIGNATURE-----

From: James Hogan <jhogan@kernel.org>
Subject: Introducing a nanoMIPS port for Linux
Date: Wed, 2 May 2018 22:51:08 +0100
Message-ID: <20180502215107.GA9884@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Matt Redfearn <matt.redfearn@mips.com>, Marcin Nowakowski <marcin.nowakowski@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>
List-Id: linux-arch.vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Yesterday MIPS Tech announced the latest generation of the MIPS family
of architectures called nanoMIPS [1]. As part of the development we have
been designing all the open source tools necessary to support the
architecture and, thanks to the speed with which we were able to
prototype, we have also been using these tools to shape the architecture
along the way. This has led to some really interesting improvements in
the tools, which MIPS would like to contribute back to the community.
While doing this work many of us have been unable to contribute to the
community as actively as we would have liked, we are therefore very
grateful for the community support given to the MIPS architecture over
the last 18 months. This announcement has a general introduction at the
start, so if you have already read it for one of the other tools, you
can skip down to the information specific to Linux.

For anyone who knows the MIPS architecture you may well wonder why we
are introducing another major variant and the question is perfectly
valid. We do admittedly have quite a few: MIPS I through MIPS IV, MIPS32
and MIPS64 through to MIPS32R6 and MIPS64R6, MIPS16e, MIPS16e2,
microMIPSR3 and microMIPSR6. Each of these serves (or served) a purpose
and there is a high level of synergy between all of them. In general,
they build upon the previous and there is a high level of compatibility,
even when switching to a new encoding like moving from MIPS to
microMIPS. The switch to MIPS32R6/MIPS64R6 was a major shift in the way
the architecture innovated and drew more on the original theory of the
architecture, where evolution was not expected to be limited by binary
compatibility. MIPS Release 6 removed instructions and did create some
very minor incompatibility but is also much cleaner to implement from a
micro-architecture perspective. We have taken this idea much further
with nanoMIPS and reimagined the instruction set, by drawing on all the
experience gained from previous designs. Hopefully others will find it
as interesting as we do.

The major driving force behind the nanoMIPS architecture was to achieve
outstanding code density, while also balancing out hardware and software
design cost. As background MIPS has two compressed ISA variants:
MIPS16e, which cannot exist without also implementing MIPS32, and
microMIPS, which can exist on its own. Since MIPS16e has specific limits
that cannot be engineered around, we chose to use an approach similar to
the microMIPS design.

nanoMIPS has a variable-length compressed instruction set that is
completely standalone from the other MIPS ISAs. It is designed to
compress the highest frequency instructions to 16-bits, and use 48-bit
instructions to efficiently encode 32-bit constants into the instruction
stream. There is also a wider range of 32-bit instructions, which merge
carefully chosen high frequency instruction sequences into single
operations creating more flexible addressing modes such as indexed and
scaled indexed addressing, branch compare with immediate and macro style
instructions. The macro like instructions compress prologue and epilogue
sequences, as well as a small number of high frequency instruction pairs
like two move instructions or a move and function call. nanoMIPS also
totally eliminates branch delay slots which follows a precedent set by
microMIPSR6.

To get the best from a new ISA we also re-engineered the ABI and created
a new symbiotic relationship between the ISA and ABI that pushes code
density and performance further still. The ABI creates a fully link time
relaxable model, which enables us to squeeze every last byte out of the
code image even when deferring final addressing mode and layout
decisions to link time. We have been mindful of MIPS heritage and
ensured that while open to any possible change, we also have minimal
impact when porting code from MIPS to nanoMIPS, and have plenty of
support to achieve source compatibility between the two.

The net effect of these changes leads to an average code size reduction
of 20% relative to microMIPSR6. This compression could well be one of
the best achieved by GNU tools for any RISC ISA. Comparing the ISA in
terms of number of instructions to issue vs microMIPS we also see a
reduction of between 8% and 11% of dynamic instruction count.

Below we dig into some technical specifics for Linux; we welcome any
feedback and questions as we start to look at rebasing this work to the
trunk/master and formally submitting it. nanoMIPS pre-built toolchains
and source code tarballs are available at:

http://codescape.mips.com/components/toolchain/nanomips/2018.04-02/

Linux specific details
======================

The intial port of the Linux kernel is available at:

  git://git.linux-mips.org/pub/scm/linux-mti.git nanomips-v4.15

You can also view the changes online here:

  https://git.linux-mips.org/cgit/linux-mti.git/commit/?h=nanomips-v4.15

This single patch is being released as the most expedient path to
releasing this work into the wild, but is of course not intended to be
submitted or merged upstream as is. This work will be prepared &
submitted as series of smaller patches.

Due to the binary incompatibility between previous MIPS architecture
generations and nanoMIPS, and the significantly revamped compiler ABI,
where for the first time, a single Linux kernel would not be expected to
handle both old and new ABIs, we have decided to also take the
opportunity to modernise the Linux user ABI for nanoMIPS, making as much
use of generic interfaces as possible and modernising the true
architecture specific parts.

This is similar to what a whole new kernel architecture would be
expected to adopt, but has been done within the existing MIPS
architecture port to allow reuse of the existing MIPS code, most of
which does not depend on these ABI specifics. Details of the proposed
Linux user ABI changes for nanoMIPS can be found here:

  https://www.linux-mips.org/wiki/P32_Linux_ABI

Contributors:
  Paul Burton, James Hogan, Matt Redfearn, Marcin Nowakowski

[1] https://www.mips.com/press/new-mips-i7200-processor-core-delivers-unmatched-performance-and-efficiency-for-advanced-lte5g-communications-and-networking-ic-designs/

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuoyuwAKCRA1zuSGKxAj
8iNCAP9NY04kV6wYl8m0EuHHB2t92jJ/lA8Gosjy8Tiyt/CeFAD/V30AyNGUBiY+
E0mJ/qzkqukf4VMkF/VnYGCuStjz2QE=
=+byj
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

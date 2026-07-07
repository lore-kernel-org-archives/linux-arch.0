Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB43392C25;
	Tue,  7 Jul 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434435; cv=none; b=V625BY5Z7DO3mFvNJwFJW9YqtsbYryiPPzxJsAoQN1QIm5hje5W5EB6njSXp+vBPfyuCOI3PRZcc0IWLXGEA/FtphiNkiAwcGL3vuk4gxSq2gk5Pn8Xmt0WxV2O8EK35QuNGUF3m04uMd8rkrcpdEXy4aH4dDOSLC9avsHzPCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434435; c=relaxed/simple;
	bh=4NwUP6aOyhMEDaz1G7Jxklo6X4SzHBzp+nAEAVS6hbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6KcMi7HBis7yrkaCKKsEzcJd6jSb2fYwCZTFqcWNOFURutWp8AZMORbTo9CZxBEBl6b53//6oOkrfsnXpX0IgShgN8b9MPd0rl9zsrBX8nfgXATSrUF3Dvk7QICSdV+zpXjHze2TpmRW/8WBUrIrmB0lF/uiI5R0ZM/ZkgstIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYY9XAYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYY9XAYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DA31F000E9;
	Tue,  7 Jul 2026 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434431;
	bh=1U8ZXFlW4rX9c/2F9h4tPUhUQFvqjXcEFFpByr/JDUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iYY9XAYYMs2G9ELeHa2Gcaq15Lq7TLnMHoVJPgo1lTK0zDQTMiglPrLXs5ocCKFuK
	 xDjlbNEM1JpdWstL9gCrcvGy+2YNVZEuWZIgEW4zQFocqVJfwka6aiJFJ3c1heTeUq
	 x8raJidAc8dA+v7YuYp8q1Gr4mUKcUGUqSlV0egPC2lt4dgPTW8eMhA9X594tTQsLL
	 YQWuHWzWzO+12Ub6hInXq2CE44mKlWXxewnZpE805jeAnRjMYUZfD9bW/ElTab88J7
	 dnkuFoO4aWfpC7RiaMkCuPnMxXS0Y4vOnqTp4QY2QjBLdQY4DZQcRuHOfJDzYEkmwT
	 9oJ1K9OTa/vIA==
Date: Tue, 7 Jul 2026 15:27:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Message-ID: <90228c39-04e7-41ef-ad91-84a8bb866650@sirena.org.uk>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <20260702-forensik-unfertig-korpulent-56f199eb061a@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CwuKocahL5R9xkrP"
Content-Disposition: inline
In-Reply-To: <20260702-forensik-unfertig-korpulent-56f199eb061a@brauner>
X-Cookie: All rights reserved.


--CwuKocahL5R9xkrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 09:47:24AM +0200, Christian Brauner wrote:
> On Sun, 31 May 2026 12:49:46 +0200, Jori Koolstra wrote:
> > vfs: missing inode operation should return a consistent error code
>=20
> I've stuffed this on a separate branch. Let's see whether we see any
> fallout.

I'm seeing a failure in the chdir01 LTP test on arm64, everything seems
to work fine apart from vfat:

tst_buffers.c:57: TINFO: Test is using guarded buffers
L5023tst_tmpdir.c:316: TINFO: Using /tmp/LTP_chdkVKCfH as tmpdir (tmpfs fil=
esystem)
L5024tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
L5025tst_test.c:2047: TINFO: LTP version: 20260130
L5026tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc2-next-20260707 #1 SMP =
PREEMPT @1783429165 aarch64
L5027tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
L5028tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 40s

=2E..

tst_test.c:1985: TINFO: =3D=3D=3D Testing on vfat =3D=3D=3D
L5158tst_test.c:1290: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extr=
a opts=3D''
L5159tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_chdkVKCfH/mntp=
oint fstyp=3Dvfat flags=3D0
L5160chdir01.c:85: TBROK: Cannot create symlinks: EOPNOTSUPP (95)

Looks like a changed the error code here has confused the test's feature
detection.  How many non-LTP applications have the same detection
algorithm is a separate question.

A full log may be visible at:

  https://lava.sirena.org.uk/scheduler/job/2954697#L5157

but I'm having a horrible time with AI scrapers at the minute so your
mileage may very much vary.

Bisect log:

# bad: [5c73cd9f0819c1c44e373e3dabb68318b1de1a12] Add linux-next specific f=
iles for 20260707
# good: [fc5f2284ad6951ce06d6881ca8cbd6d14d5f5071] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [42843a9ac5e809f0cc23d9c7fc4f7fc680ef533f] Merge branch 'vfs-7.3.io=
map' into vfs.all
# good: [9a2e05b1fd4254f89110c9ec5efd23c838e92f1b] Merge branch 'vfs-7.3.mo=
unt' into vfs.all
# good: [526b2b2b2461704c8e8ecf7c3e514221a80ddc0d] Merge branch 'vfs-7.3.ne=
tfs' into vfs.all
# good: [5c73bf8878bf4e2770549c029ea41b328993de92] Merge branch 'vfs-7.3.kt=
hread' into vfs.all
# good: [8abc1c8badc11c859bb4ba43211611347e59c55c] Merge patch series "Add =
bpf_sock_read_xattr() kfunc to read socket xattrs"
# good: [41fda7804af4931df056f74f91661edf7f696777] super: make fs_holder_op=
s private
# good: [fb3fcb406b8882a91d1e51bae97101802fc991e1] soc: document merges
# good: [4015411d5c76b22831d20f48abfe03754c2f41aa] Merge branch 'soc/dt' in=
to for-next
# good: [1c996a37fd244d19e5dbb715328c1676e28ef607] tools/power turbostat: p=
mt: Improve sscanf() hygiene
git bisect start '5c73cd9f0819c1c44e373e3dabb68318b1de1a12' 'fc5f2284ad6951=
ce06d6881ca8cbd6d14d5f5071' '42843a9ac5e809f0cc23d9c7fc4f7fc680ef533f' '9a2=
e05b1fd4254f89110c9ec5efd23c838e92f1b' '526b2b2b2461704c8e8ecf7c3e514221a80=
ddc0d' '5c73bf8878bf4e2770549c029ea41b328993de92' '8abc1c8badc11c859bb4ba43=
211611347e59c55c' '41fda7804af4931df056f74f91661edf7f696777' 'fb3fcb406b888=
2a91d1e51bae97101802fc991e1' '4015411d5c76b22831d20f48abfe03754c2f41aa' '1c=
996a37fd244d19e5dbb715328c1676e28ef607'
# test job: [42843a9ac5e809f0cc23d9c7fc4f7fc680ef533f] https://lava.sirena.=
org.uk/scheduler/job/2946674
# test job: [9a2e05b1fd4254f89110c9ec5efd23c838e92f1b] https://lava.sirena.=
org.uk/scheduler/job/2946625
# test job: [526b2b2b2461704c8e8ecf7c3e514221a80ddc0d] https://lava.sirena.=
org.uk/scheduler/job/2946471
# test job: [5c73bf8878bf4e2770549c029ea41b328993de92] https://lava.sirena.=
org.uk/scheduler/job/2946559
# test job: [8abc1c8badc11c859bb4ba43211611347e59c55c] https://lava.sirena.=
org.uk/scheduler/job/2946694
# test job: [41fda7804af4931df056f74f91661edf7f696777] https://lava.sirena.=
org.uk/scheduler/job/2946598
# test job: [fb3fcb406b8882a91d1e51bae97101802fc991e1] https://lava.sirena.=
org.uk/scheduler/job/2849417
# test job: [4015411d5c76b22831d20f48abfe03754c2f41aa] https://lava.sirena.=
org.uk/scheduler/job/2849285
# test job: [1c996a37fd244d19e5dbb715328c1676e28ef607] https://lava.sirena.=
org.uk/scheduler/job/2829780
# test job: [5c73cd9f0819c1c44e373e3dabb68318b1de1a12] https://lava.sirena.=
org.uk/scheduler/job/2954697
# bad: [5c73cd9f0819c1c44e373e3dabb68318b1de1a12] Add linux-next specific f=
iles for 20260707
git bisect bad 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
# test job: [cf6f88615485a68df77092de1f90f88708a32fa6] https://lava.sirena.=
org.uk/scheduler/job/2948415
# bad: [cf6f88615485a68df77092de1f90f88708a32fa6] Merge branch 'vfs-7.3.err=
no' into vfs.all
git bisect bad cf6f88615485a68df77092de1f90f88708a32fa6
# test job: [7028d60a643ac945826ae281ae5ec1940ee06fbf] https://lava.sirena.=
org.uk/scheduler/job/2948438
# bad: [7028d60a643ac945826ae281ae5ec1940ee06fbf] vfs: missing inode operat=
ion should return a consistent error code
git bisect bad 7028d60a643ac945826ae281ae5ec1940ee06fbf
# first bad commit: [7028d60a643ac945826ae281ae5ec1940ee06fbf] vfs: missing=
 inode operation should return a consistent error code
# test job: [7028d60a643ac945826ae281ae5ec1940ee06fbf] https://lava.sirena.=
org.uk/scheduler/job/2948438
# bad: [7028d60a643ac945826ae281ae5ec1940ee06fbf] vfs: missing inode operat=
ion should return a consistent error code
git bisect bad 7028d60a643ac945826ae281ae5ec1940ee06fbf
# first bad commit: [7028d60a643ac945826ae281ae5ec1940ee06fbf] vfs: missing=
 inode operation should return a consistent error code

--CwuKocahL5R9xkrP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpNDLoACgkQJNaLcl1U
h9DC8Af/VlaXe7QIksLACKdLRVkcQHmxZpxlySa5iEgEw5d69yk59ZecLW7pUZW9
o9WkNFYSeo9CN+hm/8gGcD4pI2m5NqbVeyJ4KQ7Nacg7XrI7T1hXPaSKQp6Su+4t
YRkMu5fMeMlg+IsK/3akb1W3Zdfu6P+N9Gxp97DuDUpugGscV3oRjxNTZs+pu0T5
iPWMsRo/N6qk1i3pYKVG+wtAiTQKfRzree8xkZVpi9CrlvfI3UJ81vJtI45NP/+m
X00Q4vOaoLkVM72hdiUuaoqble8s38We/mhlMHviEGAcG0HdzsBWrncnvy6TAqgl
KQZZ+UJNYAN8CMqtOIDZ6OBef//kOA==
=/3xL
-----END PGP SIGNATURE-----

--CwuKocahL5R9xkrP--

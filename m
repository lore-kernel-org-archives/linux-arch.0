Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E583E6385;
	Tue, 26 May 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795522; cv=none; b=GmwPMKSVXbiWPVnFLcePhrl7IFgNFczNJsU4CWPRhFpSWt3zHL0XCzHUKPp/ezzg27385M1Fj4aFPiMzMsNMcayiEPFo+W1sQrcKy1JveN5QFNATZMH+tMECAuH5zE/9PkmnnJ+FcfdhEWvaePQp03LnMV4QtPJ00AvURRwvDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795522; c=relaxed/simple;
	bh=kTAeZ3xw/Df4ezBjxQUd+PwImFlqzKYS6yA31g42XCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb+xkGsskz0KiXnoqdFeFgFQRmf1ulo5Jz0z5wV2Uj+gzoV3yldLwE8p3DSmwYXm79Q0ff1dUyGnkHi60U3sLVrTB3u/nTSusTQcNfibTK5uo5Qy8vCpdGhdq1AQjBa9zpGKnyHBGvLnF+y3v5CCKNrk1TUgz+RGoy0zeHU45DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ITIfPnNS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ITIfPnNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779795508;
	bh=kTAeZ3xw/Df4ezBjxQUd+PwImFlqzKYS6yA31g42XCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITIfPnNSj4iYGsWPx3Tx9oUQY5RTkoSnYSt5EUf34ubhh7X+6E48t9zD8QK7p9UPJ
	 XunUJqRsVIEwWtiN2Rg9Bt86WZKhK6wBBXgLhouWeUEnyeCOr/EUakWvBODqgl2TFz
	 sDgAbkSNsaErv2LOwqvJaTrHYSPNfR2ht4L4Vb1g=
Date: Tue, 26 May 2026 13:38:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
Message-ID: <4ee3c775-1fbf-45e1-8b77-5f9034f45125@t-8ch.de>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
 <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>

On 2026-05-26 12:53:22+0200, Petr Pavlu wrote:
> On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> > The module authentication functionality will also be used by the
> > hash-based module authentication. Split it out from CONFIG_MODULE_SIG
> > so it is usable by both.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > [...]
> > diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> > index f535181e0d98..84297da666ff 100644
> > --- a/kernel/module/Kconfig
> > +++ b/kernel/module/Kconfig
> > @@ -271,9 +271,12 @@ config MODULE_SIG
> >  	  debuginfo strip done by some packagers (such as rpmbuild) and
> >  	  inclusion into an initramfs that wants the module size reduced.
> >  
> > +config MODULE_AUTH
> > +	def_bool MODULE_SIG
> > +
> >  config MODULE_SIG_FORCE
> >  	bool "Require modules to be validly signed"
> > -	depends on MODULE_SIG
> > +	depends on MODULE_AUTH
> >  	help
> >  	  Reject unsigned modules or signed modules for which we don't have a
> >  	  key.  Without this, such modules will simply taint the kernel.
> 
> Should MODULE_SIG_FORCE be renamed to MODULE_AUTH_FORCE, along with
> renaming the sig_enforce functionality in kernel/module/auth.c to
> auth_enforce?

Given that it is a user-visible symbol we'll need to be a bit careful
not to break existing configurations.
I'll try to use the new "transitional" kconfig attribute.


Thomas

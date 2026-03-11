Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786F282F33;
	Wed, 11 Mar 2026 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233988; cv=none; b=d9TZzf7rQ8MZyPX18HJXDpQNImKYPWX3gs+BpMJEZ/8iI11S5FyQhJtiwT8J7SmmgRuJkjPMXqMNamRin8BrSzraw3FfzyhwhpWAHLJoSSmn423sNz9p45WdJTq6MqDfzOQwyZiaajqhXTQAEFEy8iGmRmdrIdAKuia1lSrKXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233988; c=relaxed/simple;
	bh=6iMI2XFYcGmArDxHVD1cNM01BLfDHO/WY4pBP+fXMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/tUwcikpTcsHHrNFI2YjlVjMZf7OFMN1SvomY7jJJTBql9fvZJxaVb4e539PQc8NNeMWPBf7WBXIvG/BnzBYuCUdvwqxrCZXcX1weDt2z0WQMHJQPVu34UK+FkeJPXaVC88e43Hq+awh3yVWXfadqTJCWogSUGRat4H4U0MrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CEiZ87VU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CEiZ87VU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773233984;
	bh=6iMI2XFYcGmArDxHVD1cNM01BLfDHO/WY4pBP+fXMLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEiZ87VUhKkkjxvvSxzMolbjRXZkdgJY0Rzic3nGaTRS6rUPbCgJmnQ+/+MVDz77B
	 T0VB914Hs6kRIOMVG/+6qkbqwiEQ6Ju+JDASONipQYTCXd3FloBmK2xVggCqy7Xgzr
	 wkmrvsN0vaq/eTWXkiLVV77iXHXn2bYLd9icP6MQ=
Date: Wed, 11 Mar 2026 13:59:44 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 09/17] module: Make module loading policy usable
 without MODULE_SIG
Message-ID: <2f702140-32cf-40aa-80fb-3650145a2adf@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>
 <20260310220146.GE120274@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310220146.GE120274@quark>

On 2026-03-10 15:01:46-0700, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 01:28:53PM +0100, Thomas Weißschuh wrote:
> > The loading policy functionality will also be used by the hash-based
> > module validation. Split it out from CONFIG_MODULE_SIG so it is usable
> > by both.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  include/linux/module.h  |  8 ++++----
> >  kernel/module/Kconfig   |  5 ++++-
> >  kernel/module/main.c    | 26 +++++++++++++++++++++++++-
> >  kernel/module/signing.c | 21 ---------------------
> >  4 files changed, 33 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index f288ca5cd95b..f9601cba47cd 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -444,7 +444,7 @@ struct module {
> >  	const u32 *gpl_crcs;
> >  	bool using_gplonly_symbols;
> >  
> > -#ifdef CONFIG_MODULE_SIG
> > +#ifdef CONFIG_MODULE_SIG_POLICY
> >  	/* Signature was verified. */
> >  	bool sig_ok;
> >  #endif
> [...]
> > +config MODULE_SIG_POLICY
> > +	def_bool MODULE_SIG
> 
> Maybe MODULE_AUTH_POLICY?  Hash-based module authentication does not use
> signatures.
> 
> This issue appears elsewhere in the code too.  There are lots of places
> that still refer to module signatures or "sigs", when really module
> authentication is meant.
> 
> I'm not sure how far you want to go with the renaming, but it's
> something to think about.  It's confusing to use the term "signature" to
> mean something that is not a signature.

Ack. "authentication" is much better, I'll use that.


Thomas

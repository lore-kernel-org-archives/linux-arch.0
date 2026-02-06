Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C717736;
	Fri,  6 Feb 2026 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366855; cv=none; b=s4LySjmat56PW6Bs71Fb5xOy6zymoQLAuKqK+rRj2USK/05ReTtWF/LM8TShq8OMhLiVQyJIsDSlMs9WfpM8z7pjp7VPp3WFcpo0UtAoDR/JNRN5VpaSt86tHm36QElP1PRxwQw8BTvC6QN2xUcOAeI7IjBIjLjbxJjuelN6VnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366855; c=relaxed/simple;
	bh=N6gVERObGhB15T0VBTmv5xARCwqXVSRXY8MFd6Z+hoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMAV/BcR4pht4Au577C1jO7Q30q62XijOwFSXX95c+byn5si9xXi2Y2MOZotz+LvUi6klYJHAYGKs1xEFdHQFNx551j981+qXuWP3tXF/xuL5myjqG9eb/zemLlAt6X4Isb7BQhDmhkiq65GM30XEISZCzCqUINS9lFkI6o2gXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EgAqSTaj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EgAqSTaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770366852;
	bh=N6gVERObGhB15T0VBTmv5xARCwqXVSRXY8MFd6Z+hoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgAqSTajdYeJFKCk0ywbXmuECt0fZYvujzSTRvhETEtx3/f+KtVBNsuJfW6iUHO95
	 xDBk/bqTf7KMMjXf17G01CViU2TjvoF5hm7V0YQt4BUyrOOW+RHBazyoxvvFbIQVcl
	 KTCxEkR1IahrhDbJw5ftdTKxtSQZZkdA6ovkvFgk=
Date: Fri, 6 Feb 2026 09:34:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: David Howells <dhowells@redhat.com>
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
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Message-ID: <1c30b3bc-8dba-4627-8a3e-db9fdbbce6ee@t-8ch.de>
References: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2919071.1770365933@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2919071.1770365933@warthog.procyon.org.uk>

On 2026-02-06 08:18:53+0000, David Howells wrote:
> Thomas Weißschuh <linux@weissschuh.net> wrote:
> 
> > As both 'size_t' and 'unsigned int' are always the same size, this
> > should be risk-free.
> 
> Did you mean 'unsigned long'?

Indeed, I'll fix it for the next revision.


Thomas

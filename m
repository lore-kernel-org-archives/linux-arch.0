From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [PATCH 00/20] mm: generic show_mem() v4
Date: Tue, 01 Jul 2008 08:55:27 +0200
Message-ID: <8763rq6qlc.fsf@skyscraper.fehenstaub.lan>
References: <20080627115349.743368154@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:50815 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbYGAG4b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Jul 2008 02:56:31 -0400
In-Reply-To: <20080627115349.743368154@saeurebad.de> (Johannes Weiner's
	message of "Fri, 27 Jun 2008 13:53:49 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi,

Johannes Weiner <hannes@saeurebad.de> writes:

> Every arch implements its own show_mem() function.  Most of them share
> quite some code, some of them are completely identical.
>
> This series implements a generic version of this function and migrates
> almost all architectures to it.
>
> version 4:
> 	- rebased against -mmotm

Oh, btw, do you even want them, Andrew?  Or should I base this set on
Linus' tree directly?

	Hannes

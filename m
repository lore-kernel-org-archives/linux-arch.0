Return-Path: <linux-arch-owner@vger.kernel.org>
Sender: jes@trained-monkey.org
Subject: Re: ia64-specific-dev-mem-handlers.patch
References: <20050310121618.1242b2d6.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 11 Mar 2005 06:16:44 -0500
In-Reply-To: <20050310121618.1242b2d6.akpm@osdl.org>
Message-ID: <yq0r7imzb37.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> It is believed that this will be useful to other architectures
Andrew> which allow users to uncacheably map RAM.  Could interested
Andrew> parties please comment?

Just for background, it's used in the mspec (formerly fetchop) driver
on ia64. If anyone wants a copy of this to look at in additiont to the
/dev/mem patch, let me know (it's been posted to linux-kernel already).

Cheers,
Jes

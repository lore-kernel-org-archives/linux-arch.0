From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] UAPI: Remove empty Kbuild files
Date: Tue, 26 Mar 2013 22:47:21 +0100
Message-ID: <51521769.7010707@suse.cz>
References: <20130326140520.3100447ee78322d52e6be7af@linux-foundation.org> <20130326131828.209aff73e38d3273d078bb2e@linux-foundation.org> <20130326174853.10144.36253.stgit@warthog.procyon.org.uk> <29647.1364331583@warthog.procyon.org.uk> <30061.1364333234@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46488 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab3CZVrv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Mar 2013 17:47:51 -0400
In-Reply-To: <30061.1364333234@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 26.3.2013 22:27, David Howells wrote:
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> Obviously, I thought you were referring to build-time operations.
> 
> I want to know whether I should extend my patch to remove include/Kbuild and
> any refs to it.

make headers_install starts at include/uapi, so include/Kbuild is not
needed. And new exported headers end up in inclde/uapi, so there will
probably not be need for include/Kbuild in the future either. IMO, just
remove it.

Michal

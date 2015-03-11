Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arcturus.aphlor.org ([188.246.204.175]:59720 "EHLO
	arcturus.aphlor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbCKOX3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 10:23:29 -0400
Date: Wed, 11 Mar 2015 10:23:21 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] mm: kill kmemcheck
Message-ID: <20150311142321.GA1143@codemonkey.org.uk>
References: <1426074547-21888-1-git-send-email-sasha.levin@oracle.com>
 <20150311081909.552e2052@grimm.local.home>
 <55003666.3020100@oracle.com>
 <20150311084034.04ce6801@grimm.local.home>
 <55004595.7020304@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55004595.7020304@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-ID: <20150311142321.r9gmudxPIo0bN-hEU5uyT_j2UgUoSHaoJlbJLFHSsYk@z>

On Wed, Mar 11, 2015 at 09:39:33AM -0400, Sasha Levin wrote:
 > On 03/11/2015 08:40 AM, Steven Rostedt wrote:
 > > On Wed, 11 Mar 2015 08:34:46 -0400
 > > Sasha Levin <sasha.levin@oracle.com> wrote:
 > > 
 > >> > Fair enough. We knew there are existing kmemcheck users, but KASan should be
 > >> > superior both in performance and the scope of bugs it finds. It also shouldn't
 > >> > impose new limitations beyond requiring gcc 4.9.2+.
 > >> >
 > > Ouch! OK, then I can't use it. I'm currently compiling with gcc 4.6.3.
 > > 
 > > It will be a while before I upgrade my build farm to something newer.
 > 
 > Are you actually compiling new kernels with 4.6.3, or are you using older
 > kernels as well?
 > 
 > There's no real hurry to kill kmemcheck right now, but we do want to stop
 > supporting that in favour of KASan.
 
Another question is "is kmemcheck actually finding anything right now?"
I've personally not hit anything with it in quite a while.

	Dave


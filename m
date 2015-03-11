Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:59787 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752116AbbCKMkp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Mar 2015 08:40:45 -0400
Date: Wed, 11 Mar 2015 08:40:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm: kill kmemcheck
Message-ID: <20150311084034.04ce6801@grimm.local.home>
In-Reply-To: <55003666.3020100@oracle.com>
References: <1426074547-21888-1-git-send-email-sasha.levin@oracle.com>
	<20150311081909.552e2052@grimm.local.home>
	<55003666.3020100@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-ID: <20150311124034.uX8yby9Mwg99zwUVGsd8cIElcSo66HObKh3uT17Ok8E@z>

On Wed, 11 Mar 2015 08:34:46 -0400
Sasha Levin <sasha.levin@oracle.com> wrote:

> Fair enough. We knew there are existing kmemcheck users, but KASan should be
> superior both in performance and the scope of bugs it finds. It also shouldn't
> impose new limitations beyond requiring gcc 4.9.2+.
>

Ouch! OK, then I can't use it. I'm currently compiling with gcc 4.6.3.

It will be a while before I upgrade my build farm to something newer.

-- Steve

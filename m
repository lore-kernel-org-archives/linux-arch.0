Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49998 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752210AbYDNWPA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Apr 2008 18:15:00 -0400
Date: Mon, 14 Apr 2008 15:14:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv4 1/2] kernel: add common infrastructure for unaligned
 access
Message-ID: <20080414151417.f8ab4365.akpm@linux-foundation.org>
In-Reply-To: <1208195406.5721.47.camel@brick>
References: <1208195406.5721.47.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, dhowells@redhat.com, rmk@arm.linux.org.uk
Message-ID: <20080414221417.Y0yJRQ1l__sgudqdbFNJjf6kQ-HB8VncsfIa1-X1OPg@z>

On Mon, 14 Apr 2008 10:50:06 -0700
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Create a linux/unaligned folder similar in spirit to the linux/byteorder
> folder to hold generic implementations collected from various arches.

ooh, there's a cultural faux pas.  I changed it to "directory" ;)

> [Andrew: I think we're getting close to something that could go into -mm]

I queued them up, thanks.

From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] generic debug pagealloc
Date: Wed, 4 Mar 2009 23:13:44 +0900
Message-ID: <20090304141343.GB7168@localhost.localdomain>
References: <20090303160103.GB5812@localhost.localdomain> <49AD56F3.6020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:32018 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbZCDONv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2009 09:13:51 -0500
Content-Disposition: inline
In-Reply-To: <49AD56F3.6020305@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org

On Tue, Mar 03, 2009 at 05:12:35PM +0100, Jiri Slaby wrote:
> Just an optimisation: pass the i to the dump_broken_mem as a start index.

OK. I'll remove that redundancy in next verserion.

From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 3/4] ia64 mcount offset calculation
Date: Tue, 17 May 2011 07:20:54 -0400
Message-ID: <1305631254.5456.669.camel@gandalf.stny.rr.com>
References: <20110510081039.241831019@de.ibm.com>
	 <20110510081103.902546467@de.ibm.com>
	 <1305572301.5456.24.camel@gandalf.stny.rr.com>
	 <987664A83D2D224EAE907B061CE93D5301CD197F7B@orsmsx505.amr.corp.intel.com>
	 <20110517100456.6abef0de@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:62012 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab1EQLU4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2011 07:20:56 -0400
In-Reply-To: <20110517100456.6abef0de@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, 2011-05-17 at 10:04 +0200, Martin Schwidefsky wrote:
> On Mon, 16 May 2011 12:17:15 -0700

> I tried to do a test compile with/without the patch but with the latest git
> kernels TRACING_SUPPORT depends on TRACE_IRQFLAGS_SUPPORT which is missing
> for ia64. No luck ..

How hard would it be to add TRACE_IRQFLAGS_SUPPORT. That should allow
for including not only tracing, but also lockdep.

Although, I may be able to make function tracing work without it.

-- Steve

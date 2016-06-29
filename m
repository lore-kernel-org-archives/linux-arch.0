From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH v2] ftrace: Reduce size of function graph entries
Date: Tue, 28 Jun 2016 23:22:31 -0400
Message-ID: <20160628232231.54549d29@gandalf.local.home>
References: <1467091840-4625-1-git-send-email-namhyung@kernel.org>
	<20160628193200.71629fc5@gandalf.local.home>
	<20160629013234.GA1628@sejong>
	<20160628215738.6e4815dd@gandalf.local.home>
	<20160629023837.GD1628@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:46900 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752449AbcF2DWe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jun 2016 23:22:34 -0400
In-Reply-To: <20160629023837.GD1628@sejong>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Wed, 29 Jun 2016 11:38:37 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Ok then, I'll change it to use 'packed' only in v3.
> 

I would add a comment that the structure is already packed and that the
"packed" attribute is just to remove the extra padding at the end of
the struct.

-- Steve

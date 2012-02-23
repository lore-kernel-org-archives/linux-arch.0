From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: > 6 kernel arguments?
Date: Thu, 23 Feb 2012 10:11:43 -0600
Message-ID: <1330013503.2961.14.camel@dabdike.int.hansenpartnership.com>
References: <4F43DD24.20309@zytor.com> <31890.1329903605@redhat.com>
	 <59d3eb2b-82f1-4de4-9dbe-7bff6e6bf8fa@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34538 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752535Ab2BWQLp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Feb 2012 11:11:45 -0500
In-Reply-To: <59d3eb2b-82f1-4de4-9dbe-7bff6e6bf8fa@email.android.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, Linux Arch Mailing List <linux-arch@vger.kernel.org>

On Wed, 2012-02-22 at 07:02 -0800, H. Peter Anvin wrote:
> Yes, system call arguments.  I vaguely remember there being some
> architecture supporting 7 since pselect() was introduced, but I could
> just be full of it.

The parisc ABI allows for up to 8 register based arguments to a system
(or indeed any function) call.  However, in deference to the usual linux
calling conventions, we only use seven of them (one for the syscall
number and 6 for the arguments).  We definitely use pselect6.  I think
the architecture you're thinking of is microblaze, but it's obsoleted
it's seven argument version of pselect.

James

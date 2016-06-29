From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC/PATCH v2] ftrace: Reduce size of function graph entries
Date: Wed, 29 Jun 2016 11:38:37 +0900
Message-ID: <20160629023837.GD1628@sejong>
References: <1467091840-4625-1-git-send-email-namhyung@kernel.org>
 <20160628193200.71629fc5@gandalf.local.home>
 <20160629013234.GA1628@sejong>
 <20160628215738.6e4815dd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:53203 "EHLO
	lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbcF2Cim (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2016 22:38:42 -0400
In-Reply-To: <20160628215738.6e4815dd@gandalf.local.home>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Tue, Jun 28, 2016 at 09:57:38PM -0400, Steven Rostedt wrote:
> On Wed, 29 Jun 2016 10:32:34 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > is at 32-37
> > > 
> > > For a total of 38 bytes. I'm betting that without the packed, the 4
> > > extra bytes will always be at the end.  
> > 
> > Woundn't it be 36 or 40 bytes? :)
> 
> Ug, don't know what I was counting then. I added the 64 bit version as
> a after thought.
> 
> > 
> > > 
> > > If the compiler places it incorrectly without any attribute, it will
> > > fail to read the long long if the arch requires 64 bits to be 8 bytes
> > > aligned. The alignment is meaningless here. All we need is "packed" and
> > > be done with it. It's only going to truncate the 4 bytes at the end of
> > > the structure if that.  
> > 
> > I agree that in-struct alignment preserved without the 'aligned'
> > attribute but I'm not sure whether it's guaranteed that the *start*
> > address of the struct is still in proper alignment boundary.
> > 
> > IOW the struct ftrace_graph_ret should be placed at 8-byte boundary in order
> > to keep alignment of struct members.  Is it guaranteed after applying
> > 'packed'?
> > 
> 
> My point is, a structure doesn't change size depending on where it is
> located. Thus, if a structure contains a 8 byte field, that must be 8
> bytes aligned due to architecture constraints, then it had better be
> aligned that way everywhere. If it is not, then accessing the 8 byte
> fields will cause issues.
> 
> The only thing that the "packed" changes, is it removes the last 4
> padded bytes of the structure. It doesn't change anything else. Hence,
> the alignment is just extra and unneeded.

Ok then, I'll change it to use 'packed' only in v3.

Thanks,
Namhyung

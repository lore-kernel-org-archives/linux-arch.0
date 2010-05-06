From: Michal Marek <mmarek@suse.cz>
Subject: Re: kbuild: fixing the select problem
Date: Thu, 06 May 2010 16:24:13 +0200
Message-ID: <4BE2D10D.4070706@suse.cz>
References: <1273096160.23208.35.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1273096160.23208.35.camel@mulgrave.site>
Sender: linux-kbuild-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>, Vegard Nossum <vegard.nossum@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 5.5.2010 23:49, James Bottomley wrote:
> [Sam: I know you don't maintain kbuild anymore, but since you have the
> most experience, if you could find time to comment, I'd be grateful]
> 
> The select problem is that the kbuild select directive will turn a
> symbol on without reference to its dependencies.  This, in turn, means
> that either selected symbols must select their dependencies, or that
> people using select have to be aware of the selected symbol's dependency
> and build those dependencies into their symbol (leading to duplication
> and the possibility of getting the dependencies out of sync).  We use
> select for the scsi transport classes, so we run into this problem in
> SCSI quite a lot.
> 
> I think the correct fix is to make a symbol that selects another symbol
> automatically inherit all of the selected symbol's dependencies.
> 
> There seems to be a fairly easy way to do this in kbuild.  Right at the
> moment, select is handled as additional symbol values as the last point
> in the symbol tree evaluation process.  Instead, what I propose doing is
> for every select symbol, we add an extra unconditional default for the
> selected symbol of the selecting symbol's current value (this breaks a
> possible dependency cycle) and add to the dependencies of the selecting
> symbol, the symbol it's currently selecting.

Nice trick :-).


> There's one wrinkle to all of this in that the current parser for
> default values stops when it finds the first valid (i.e. whose if clause
> evaluates to true) default.  To make the above scheme work, I need to
> modify the default parser so it takes the highest tristate of all the
> valid defaults (and bumps m to y for bool).

We should check if some Kconfig file doesn't rely on this "first hit"
behavior and fix it to explicitly list the condition for a given
default. Another option would be to add
default SYM1 || SYM2
to a symbol selected by SYM1 and SYM2.


> Does this look acceptable to people?  I think it should give the desired
> result and has the added benefit that we can then strip the extra select
> overlay out of the kbuild system (making the parser slightly simpler).
> 
> If this looks like a good idea to people, I think I can code up a quick
> patch.

Other than the above, right now I don't see any issues with such approach.

On a related note, I see Vegard's GSoC project to use a sat solver for
kconfig got accepted [1]. Vegard, how is the project progressing?

[1]
http://socghop.appspot.com/gsoc/student_project/show/google/gsoc2010/psu_home/t127230762803

Michal

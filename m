From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: kbuild: fixing the select problem
Date: Wed, 05 May 2010 17:49:20 -0400
Message-ID: <1273096160.23208.35.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-arch.vger.kernel.org

[Sam: I know you don't maintain kbuild anymore, but since you have the
most experience, if you could find time to comment, I'd be grateful]

The select problem is that the kbuild select directive will turn a
symbol on without reference to its dependencies.  This, in turn, means
that either selected symbols must select their dependencies, or that
people using select have to be aware of the selected symbol's dependency
and build those dependencies into their symbol (leading to duplication
and the possibility of getting the dependencies out of sync).  We use
select for the scsi transport classes, so we run into this problem in
SCSI quite a lot.

I think the correct fix is to make a symbol that selects another symbol
automatically inherit all of the selected symbol's dependencies.

There seems to be a fairly easy way to do this in kbuild.  Right at the
moment, select is handled as additional symbol values as the last point
in the symbol tree evaluation process.  Instead, what I propose doing is
for every select symbol, we add an extra unconditional default for the
selected symbol of the selecting symbol's current value (this breaks a
possible dependency cycle) and add to the dependencies of the selecting
symbol, the symbol it's currently selecting.

There's one wrinkle to all of this in that the current parser for
default values stops when it finds the first valid (i.e. whose if clause
evaluates to true) default.  To make the above scheme work, I need to
modify the default parser so it takes the highest tristate of all the
valid defaults (and bumps m to y for bool).

Does this look acceptable to people?  I think it should give the desired
result and has the added benefit that we can then strip the extra select
overlay out of the kbuild system (making the parser slightly simpler).

If this looks like a good idea to people, I think I can code up a quick
patch.

James




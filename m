From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture:
	fixes headers_install
Date: Tue, 11 Mar 2008 10:33:15 +0100
Message-ID: <je7ig9hag4.fsf@sykes.suse.de>
References: <200803071326.06682.borntraeger@de.ibm.com>
	<20080310232039.d2a34f5a.akpm@linux-foundation.org>
	<1205217745.2592.86.camel@shinybook.infradead.org>
	<200803110810.49759.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200803110810.49759.borntraeger@de.ibm.com> (Christian
	Borntraeger's message of "Tue\, 11 Mar 2008 08\:10\:49 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, mm-commits@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

Christian Borntraeger <borntraeger@de.ibm.com> writes:

>  include/asm-alpha/kvm.h        |    6 ++++++

Can't you put it in asm-generic?

Andreas.

-- =

Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

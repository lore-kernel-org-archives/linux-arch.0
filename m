From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Date: Wed, 19 Jun 2019 14:50:34 +0200
Message-ID: <20190619125034.GA8909@andrea>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-16198-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Johannes Berg <johannes@sipsolutions.net>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infr>
List-Id: linux-arch.vger.kernel.org

>  rename Documentation/{ => driver-api}/atomic_bitops.rst (99%)

Same here: NAK, this document does not belong to driver-api.

I also realize that, despite previous notices, you keep touching
documentation without even CC-ing the people who care...

  Andrea

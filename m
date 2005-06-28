Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 09:27:10 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: input compat stuff
Message-ID: <20050628072710.GA29916@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=52658bb685df77f71e97f1b503dee97d27a88b0f;hp=024ac44c701d43f5e2d34bd6a35b2813a36e6010

besides this beeing butt ugly didn't we have a rule about never checking
task flags whether we're a compat process?  And if we're going to allow
it it should be done properly.

Wish someone would review input patches :P
